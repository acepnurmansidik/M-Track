// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tracking/cubit/user/user_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<UserCubit>().fetchInitiate();
    context.read<WalletCubit>().fetchUserWallet();
    Timer(const Duration(seconds: 3), () async {
      // Create storage
      AndroidOptions getAndroidOptions() => const AndroidOptions(
            encryptedSharedPreferences: true,
          );
      final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
      String? tokeAvailable = await storage.read(key: 'token');
      if (tokeAvailable == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        // context.read<PageCubit>().setPage(0);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/img_logo.png"))),
        ),
      ),
    );
  }
}

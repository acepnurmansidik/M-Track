// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      // Create storage
      AndroidOptions getAndroidOptions() => const AndroidOptions(
            encryptedSharedPreferences: true,
          );
      final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
      await storage.write(
          key: "token",
          value:
              "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvaG4uZG9lQGdtYWlsLmNvbSIsIm5hbWUiOiJqb2huIGRvZSIsImlhdCI6MTczNDE1NzYxMiwiZXhwIjoxNzM0MjQ0MDEyLCJqdGkiOiI4NDJiMDQzNTg3Yjc0N2U1ODdkNDFmYzQ1ZWQxOGY4MCJ9.hP5Jlpx8FBr5CsVUwElTpnevJy8MQaIe_LoAgoSr0amc8PRB7k-JRpbjnDtKdofxzcNH-oxOS3vqbAjhd1fZnQ");
      String? tokeAvailable = await storage.read(key: 'token');
      if (tokeAvailable == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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

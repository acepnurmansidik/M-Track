import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/cubit/page_cubit.dart';
import 'package:tracking/firebase_options.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';
import 'package:tracking/pages/main_page.dart';
import 'package:tracking/pages/sign_in_page.dart';
import 'package:tracking/pages/sign_up_page.dart';
import 'package:tracking/pages/splash_page.dart';
import 'package:tracking/pages/success_page.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => TransactionCubit()),
        BlocProvider(create: (context) => WalletCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SplashPage(),
          "/main": (context) => const MainPage(),
          "/sign-up": (context) => const SignUpPage(),
          "/sign-in": (context) => const SignInPage(),
          "/success-page": (context) => const SuccessPage(),
        },
      ),
    );
  }
}

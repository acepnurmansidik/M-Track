import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/cubit/auth_cubit.dart';
import 'package:tracking/cubit/page_cubit.dart';
import 'package:tracking/cubit/refparamater_cubit.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/firebase_options.dart';
import 'package:tracking/pages/form_transaction_page.dart';
import 'package:tracking/pages/home_page.dart';
import 'package:tracking/pages/setting_page.dart';
import 'package:tracking/pages/signin_page.dart';
import 'package:tracking/pages/signup_page.dart';
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
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
        BlocProvider(create: (context) => RefparamaterCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => PageCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SplashPage(),
          "/sign-up": (context) => const SignUpPage(),
          "/sign-in": (context) => const SignInPage(),
          "/home": (context) => const HomePage(),
          "/success": (context) => const SuccessPage(),
          "/setting": (context) => const SettingPage(),
          "/form-cashflow": (context) => const FormTransactionPage(),
        },
      ),
    );
  }
}

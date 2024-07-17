import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/auth_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_notif.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _showNotif = false;
  String _notifMsg = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(text: "");
    TextEditingController passwordController = TextEditingController(text: "");

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Text(
          "Sign In",
          style: blackTextStyle.copyWith(fontSize: 28, fontWeight: semibold),
        ),
      );
    }

    Widget formRegister() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          children: [
            CustomeTextFormFieldItem(
                controller: emailController,
                title: 'Email',
                isNumberOnly: false,
                hintText: 'Enter your email'),
            CustomeTextFormFieldItem(
                controller: passwordController,
                title: 'Password',
                isNumberOnly: false,
                hintText: 'Enter your password'),
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is AuthFailed) {
            setState(() {
              _showNotif = true;
              _notifMsg = state.error;
            });
            Timer(const Duration(seconds: 3), () {
              _showNotif = false;
              _notifMsg = "";
            });
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomButton(
            title: 'Submit',
            margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
            onPressed: () {
              if (emailController.text != "" || passwordController.text != "") {
                context.read<AuthCubit>().signIn({
                  "email": emailController.text,
                  "password": passwordController.text,
                });
              } else {
                setState(() {
                  _showNotif = true;
                  _notifMsg = "please enter field";
                });
                Timer(const Duration(seconds: 3), () {
                  _showNotif = false;
                  _notifMsg = "";
                });
              }
            },
          );
        },
      );
    }

    Widget tachButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-up');
        },
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 73),
          alignment: Alignment.center,
          child: Text(
            'Don\'t have account? Sign Up',
            style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              header(),
              formRegister(),
              buttonSubmit(),
              tachButton(),
            ],
          ),
          _showNotif
              ? CustomNotif(
                  errMsg: _notifMsg,
                  isErr: true,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

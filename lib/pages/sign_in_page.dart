import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColors,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          _headerSection(),
          _formSection(),
          _buttonSubmit(),
          _tachButton()
        ],
      ),
    );
  }

  Widget _headerSection() {
    return Container(
      margin: const EdgeInsets.only(top: 75, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login an Account',
            style: blackTextStyle.copyWith(fontSize: 26, fontWeight: bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Explore financials products and rewards',
            style: greyTextStyle.copyWith(
              fontSize: 14,
              color: kGreyColor.withOpacity(.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormFieldItem(
            controller: emailController,
            title: 'email',
            isNumberOnly: false,
            hintText: 'Ex: johndoe@gmail.com',
            validateFunc: (value) {
              return null;
            },
          ),
          CustomTextFormFieldItem(
            controller: passwordController,
            title: 'password',
            isNumberOnly: false,
            hintText: 'Enter your password',
            secureType: true,
            validateFunc: (value) {
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buttonSubmit() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 50),
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: kPrimaryV2Color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        "Sign In",
        style: whiteTextStyle.copyWith(
            fontSize: 14, fontWeight: bold, letterSpacing: 1),
      ),
    );
  }

  Widget _tachButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/sign-up',
          (route) => false,
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 30),
        child: Text.rich(
          TextSpan(text: "Have not account?", children: [
            TextSpan(
              text: "Sign Up",
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: kPrimaryV2Color,
              ),
            ),
          ]),
          style: blackTextStyle.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

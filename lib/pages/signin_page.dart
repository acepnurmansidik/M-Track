import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              hintText: 'Enter your email',
              validateFunc: (value) {
                return null;
              },
            ),
            CustomeTextFormFieldItem(
              controller: passwordController,
              title: 'Password',
              secureType: true,
              isNumberOnly: false,
              hintText: 'Enter your password',
              validateFunc: (value) {
                return null;
              },
            ),
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return CustomButton(
        title: 'Submit',
        margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
        onPressed: () {},
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
      backgroundColor: kWhiteColor,
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
        ],
      ),
    );
  }
}

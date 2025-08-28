import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_textform_field_border.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColors,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          _headerSection(),
          _formSection(),
          _termcondition(),
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
            'Create an Account',
            style: blackTextStyle.copyWith(fontSize: 26, fontWeight: bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Create a commitment-free profile to explore financials products and rewards',
            style: greyTextStyle.copyWith(
              fontSize: 14,
              color: kGreyColor.withOpacity(.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _termcondition() {
    return Container(
      margin: const EdgeInsets.only(bottom: 45),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 18,
            width: 18,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: kRedColor,
            ),
          ),
          const SizedBox(width: 8),
          Text.rich(
            TextSpan(
              text: 'By starting my application I agree to follow \n',
              style: greyTextStyle.copyWith(fontSize: 14),
              children: [
                TextSpan(
                  text: 'Terms of service',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
                const TextSpan(
                  text: ' and ',
                ),
                TextSpan(
                  text: 'Privacy Police',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextformFieldBorder(
            controller: confirmPasswordController,
            title: 'wallet name',
            isNumberOnly: false,
            hintText: 'Choose ypur wallet currency',
            validateFunc: (value) {
              return null;
            },
          ),
          CustomTextformFieldBorder(
            controller: confirmPasswordController,
            title: 'wallet name',
            isNumberOnly: false,
            hintText: 'Enter your wallet name',
            validateFunc: (value) {
              return null;
            },
          ),
          CustomTextformFieldBorder(
            controller: nameController,
            title: 'fullname',
            isNumberOnly: false,
            hintText: 'Ex: John Doe',
            validateFunc: (value) {
              return null;
            },
          ),
          CustomTextformFieldBorder(
            controller: emailController,
            title: 'email',
            isNumberOnly: false,
            hintText: 'Ex: johndoe@gmail.com',
            validateFunc: (value) {
              return null;
            },
          ),
          CustomTextformFieldBorder(
            controller: passwordController,
            title: 'password',
            isNumberOnly: false,
            hintText: 'Enter your password',
            validateFunc: (value) {
              return null;
            },
          ),
          CustomTextformFieldBorder(
            controller: confirmPasswordController,
            title: 'confirm password',
            isNumberOnly: false,
            hintText: 'Enter your confirm password',
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
        "Sign Up",
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
          '/sign-in',
          (route) => false,
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 30),
        child: Text.rich(
          TextSpan(text: "Already have an account?", children: [
            TextSpan(
              text: "Sign In",
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

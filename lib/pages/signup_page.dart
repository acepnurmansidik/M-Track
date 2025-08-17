import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: "");
    TextEditingController emailController = TextEditingController(text: "");
    TextEditingController passwordController = TextEditingController(text: "");
    TextEditingController confirmPasswordController =
        TextEditingController(text: "");

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Text(
          "Join us and save \nyour money",
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
              controller: nameController,
              title: 'Name',
              isNumberOnly: false,
              hintText: 'Enter your name',
              validateFunc: (value) {
                return null;
              },
            ),
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
              validateFunc: (value) {
                return null;
              },
              title: 'Password',
              isNumberOnly: false,
              secureType: true,
              hintText: 'Enter your password',
            ),
            CustomeTextFormFieldItem(
              controller: confirmPasswordController,
              validateFunc: (value) {
                return null;
              },
              title: 'Confirm Password',
              isNumberOnly: false,
              secureType: true,
              hintText: 'Enter your confirm password',
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
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 73),
          alignment: Alignment.center,
          child: Text(
            'Have your account? Sign In',
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

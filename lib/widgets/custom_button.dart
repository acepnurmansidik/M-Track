import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class CustomButton extends StatelessWidget {
  final double widthBtn;
  final String title;
  final EdgeInsets margin;
  final Function() onPressed;

  const CustomButton(
      {super.key,
      this.widthBtn = double.infinity,
      required this.title,
      required this.margin,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthBtn,
      height: 60,
      margin: margin,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryV2Color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
              letterSpacing: 1.5,
            ),
          )),
    );
  }
}

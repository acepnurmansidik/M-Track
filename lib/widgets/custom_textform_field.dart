import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class CustomeTextFormFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final bool isNumberOnly;
  final EdgeInsets padding;
  final double width;

  const CustomeTextFormFieldItem({
    super.key,
    required this.controller,
    required this.title,
    required this.isNumberOnly,
    this.padding = EdgeInsets.zero,
    required this.hintText,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 14),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
              controller: controller,
              cursorColor: kBlackColor,
              keyboardType:
                  isNumberOnly ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: kGreyColor))))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class CustomTextFormFieldItem extends StatefulWidget {
  final TextEditingController controller;
  final double fontSize;
  final FontWeight fontWeight;
  final String hintText;
  final String title;
  final bool isNumberOnly;
  final bool secureType;
  final EdgeInsets padding;
  final double width;
  final String? Function(String?)
      validateFunc; // Ubah tipe menjadi fungsi yang menerima String? dan mengembalikan String?

  const CustomTextFormFieldItem({
    super.key,
    required this.controller,
    required this.title,
    required this.isNumberOnly,
    required this.validateFunc,
    this.secureType = false,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.padding = EdgeInsets.zero,
    required this.hintText,
    this.width = double.infinity,
  });

  @override
  State<CustomTextFormFieldItem> createState() =>
      _CustomTextFormFieldItemState();
}

class _CustomTextFormFieldItemState extends State<CustomTextFormFieldItem> {
  late FocusNode _focusNode;
  Color focusColor = kGreyColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Add listener to focus node
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          focusColor = kPrimaryV2Color; // Change title color to blue on focus
        } else {
          focusColor = kGreyColor; // Revert title color
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            toTitleCase(widget.title),
            style: secondaryTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
              color: focusColor,
            ),
          ),
          const SizedBox(height: 7),
          TextFormField(
            focusNode: _focusNode,
            style: blackTextStyle.copyWith(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
            controller: widget.controller,
            obscureText: widget.secureType,
            cursorColor: kBlackColor,
            validator: widget.validateFunc, // Ubah ini
            keyboardType:
                widget.isNumberOnly ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: kPrimaryV2Color,
                  width: 1,
                ), // Ganti warna dan lebar sesuai kebutuhan
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: kPrimaryV2Color, width: 2),
              ),
              errorStyle: redTextStyle.copyWith(
                fontSize: 10,
              ),
              errorMaxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}

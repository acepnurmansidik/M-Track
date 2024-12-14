import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class CustomeTextFormFieldItem extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final bool isNumberOnly;
  final bool secureType;
  final EdgeInsets padding;
  final double width;

  const CustomeTextFormFieldItem({
    super.key,
    required this.controller,
    required this.title,
    required this.isNumberOnly,
    this.secureType = false,
    this.padding = EdgeInsets.zero,
    required this.hintText,
    this.width = double.infinity,
  });

  @override
  State<CustomeTextFormFieldItem> createState() =>
      _CustomeTextFormFieldItemState();
}

class _CustomeTextFormFieldItemState extends State<CustomeTextFormFieldItem> {
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
        children: [
          Text(
            widget.title,
            style: secondaryTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
              color: focusColor,
              letterSpacing: 1,
            ),
          ),
          TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: widget.secureType,
            cursorColor: kBlackColor,
            keyboardType:
                widget.isNumberOnly ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryV2Color, width: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}

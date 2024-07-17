import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tracking/theme.dart';

class CustomNotif extends StatelessWidget {
  final String errMsg;
  final bool isErr;
  const CustomNotif({
    super.key,
    required this.errMsg,
    this.isErr = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 50),
        padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin - 10,
            top: 10,
            bottom: 10),
        decoration: BoxDecoration(
            color: isErr ? kRedColor : kGreenColor,
            borderRadius: BorderRadius.circular(10)),
        child: Flexible(
          child: SizedBox(
            width: 250,
            child: Text(
              errMsg,
              style: whiteTextStyle.copyWith(
                fontSize: 14,
              ),
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}

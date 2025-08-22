// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class BalanceInfoFailed extends StatelessWidget {
  bool isCollapse;
  BalanceInfoFailed({super.key, required this.isCollapse});

  @override
  Widget build(BuildContext context) {
    Widget headerItem(String title, IconData icon) {
      return Container(
        height: 35,
        margin: const EdgeInsets.only(right: 8),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: kPrimaryV2Color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: kBaseColors,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                color: kBaseColors,
                fontWeight: medium,
                fontSize: isCollapse ? 14 : 16,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Your balance',
              style: greyTextStyle.copyWith(fontSize: 14),
            )
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '0',
          style: blackTextStyle.copyWith(
            fontSize: isCollapse ? 38 : 40,
            fontWeight: semibold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 7),
          child: Row(
            children: [
              headerItem('Request', Icons.add_card),
              headerItem('Transfer', Icons.send),
            ],
          ),
        )
      ],
    );
  }
}

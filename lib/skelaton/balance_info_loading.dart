// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking/theme.dart';

class BalanceInfoLoading extends StatelessWidget {
  bool isCollapse;
  BalanceInfoLoading({super.key, required this.isCollapse});

  @override
  Widget build(BuildContext context) {
    Widget headerItem(String title, IconData icon) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 35,
          width: 110,
          margin: const EdgeInsets.only(right: 8),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: kPrimaryV2Color,
            borderRadius: BorderRadius.circular(100),
          ),
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
        const SizedBox(height: 5),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.only(top: 10),
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

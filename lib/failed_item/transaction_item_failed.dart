// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class TransactionItemFailed extends StatelessWidget {
  bool isIncome;
  TransactionItemFailed({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue[50],
                  ),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: const AssetImage(
                            'assets/reload.png',
                          ),
                          colorFilter: ColorFilter.mode(
                            kPrimaryV2Color, // Warna biru yang diinginkan
                            BlendMode
                                .srcATop, // Mode blending yang tepat untuk tint
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width - 104,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reload",
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                          Text(
                            formatRupiah(0),
                            style: blackTextStyle.copyWith(
                              fontWeight: bold,
                              color: isIncome ? kGreenColor : kRedColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ". . . . . . . . . . . .",
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

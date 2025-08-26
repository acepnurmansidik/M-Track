// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class WalletItem extends StatelessWidget {
  int nominal;
  String vaNumber;
  String precentage;
  String number;
  String exp;
  String currency;

  WalletItem({
    super.key,
    this.nominal = 0,
    this.vaNumber = "XXXX XXXX XXXX XXXX XXXX",
    this.number = "XXXX XXXX",
    this.exp = "00/00",
    this.precentage = "~0",
    this.currency = "-",
  });

  @override
  Widget build(BuildContext context) {
    Widget itemCard(String title, String subtitle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 12,
              color: kWhiteColor.withOpacity(.8),
            ),
          ),
          Text(
            subtitle,
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              color: kWhiteColor,
              fontWeight: semibold,
            ),
          ),
        ],
      );
    }

    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: kPrimaryV2Color,
        image: DecorationImage(
          image: const AssetImage('assets/img_background.png'),
          colorFilter: ColorFilter.mode(
            kWhiteColor.withOpacity(.15),
            BlendMode.srcIn,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatCurrency(nominal),
                    style: whiteTextStyle.copyWith(
                      fontSize: 28,
                      fontWeight: semibold,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "$precentage%",
                      children: [
                        TextSpan(
                          text: " from last month",
                          style: whiteTextStyle.copyWith(
                            fontWeight: light,
                          ),
                        ),
                      ],
                      style: whiteTextStyle.copyWith(fontWeight: semibold),
                    ),
                  ),

                  // )
                ],
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      kWhiteColor,
                      BlendMode.srcIn,
                    ),
                    image: const AssetImage(
                      'assets/contactless-payment.png',
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Text(
              vaNumber,
              style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: light,
              ),
            ),
          ),
          Row(
            children: [
              itemCard("Number", "**** ${number.split(" ")[1]}"),
              const SizedBox(width: 12),
              itemCard("Exp", exp),
              const SizedBox(width: 12),
              itemCard("Currency", currency),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracking/pages/detail_transaction_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/custom_widget.dart';
import 'package:tracking/utils/others.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String isIncome;
  final int nominal;
  final String datetime;
  final double paddingHorizontal;

  const TransactionItem({
    super.key,
    required this.nominal,
    required this.datetime,
    required this.title,
    required this.isIncome,
    this.paddingHorizontal = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRoute(
            DetailTransactionPage(
              title: "transportation",
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: paddingHorizontal,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/${title.replaceAll(" ", "").toLowerCase()}.png',
                      ),
                      colorFilter: ColorFilter.mode(
                        kPrimaryV2Color, // Warna biru yang diinginkan
                        BlendMode
                            .srcATop, // Mode blending yang tepat untuk tint
                      )),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toTitleCase(title),
                    style: blackTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    datetime,
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isIncome == "income" ? "+" : "-"}${formatRupiah(nominal)}',
                  style: blackTextStyle.copyWith(
                    fontWeight: semibold,
                    color: isIncome == "income" ? kGreenColor : kRedColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

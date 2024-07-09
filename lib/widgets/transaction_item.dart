import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking/model/transaction_model.dart';
import 'package:tracking/pages/detail_page.dart';
import 'package:tracking/theme.dart';

class TransactionItem extends StatelessWidget {
  final bool grafik = false;
  final TransactionModel transaction;
  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(transaction: transaction)));
      },
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Icon(
                Icons.train,
                color: kBlueColor,
                size: 40,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.typeId["value"],
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: medium),
                  ),
                  Text(
                    transaction.categoryId["value"],
                    style: greyTextStyle.copyWith(fontWeight: light),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: grafik ? 0.7854 : -0.7854,
                  child: Icon(
                    grafik ? Icons.arrow_upward : Icons.arrow_downward,
                    color: grafik ? kGreenColor : kRedColor,
                  ),
                ),
                Text(
                  NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                      .format(transaction.amount),
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

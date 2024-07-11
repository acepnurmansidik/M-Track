import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/pages/detail_page.dart';
import 'package:tracking/pages/success_page.dart';
import 'package:tracking/pages/transaction_page.dart';
import 'package:tracking/theme.dart';

class TransactionItem extends StatelessWidget {
  final bool grafik;
  final TransactionModel transaction;

  const TransactionItem({
    super.key,
    required this.grafik,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      transaction: transaction,
                    )));
      },
      child: Dismissible(
        key: Key(transaction.id),
        background: slideEditBackground(),
        secondaryBackground: slideDeleteBackground(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Dragged to the left
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => TransactionPage()));
          } else {
            // Dragged to the right
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => SuccessPage()));
          }
        },
        child: Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: medium),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget slideEditBackground() {
    return Container(
      color: Colors.green,
      height: 80,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget slideDeleteBackground() {
    return Container(
      color: Colors.red,
      height: 80,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

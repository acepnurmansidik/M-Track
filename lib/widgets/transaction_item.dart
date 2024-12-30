import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/pages/transaction_page.dart';
import 'package:tracking/pages/detail_page.dart';
import 'package:tracking/theme.dart';

class TransactionItem extends StatelessWidget {
  final bool grafik;
  final TrxItemModel transaction;
  final Function(bool, String) cancelBtn;

  const TransactionItem({
    super.key,
    required this.grafik,
    required this.transaction,
    required this.cancelBtn,
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
            ),
          ),
        );
      },
      child: Dismissible(
        key: Key(transaction.id),
        background: slideEditBackground(),
        secondaryBackground: slideDeleteBackground(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Dragged to the left
            return cancelBtn(true, transaction.id);
          } else {
            // Dragged to the right
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TransactionPage(transactions: transaction),
              ),
            );
            // return cancelBtn(false);
          }
        },
        child: Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(245, 245, 245, 245),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.network(
                    '${dotenv.env["PUBLIC_API_BASE_IMAGE"]}${transaction.categoryId["icon"]["name"]}'),
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
                  Text(
                    NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                        .format(transaction.totalAmount),
                    style: transaction.isIncome
                        ? greenTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semibold,
                          )
                        : redTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.datetime,
                    style: greyTextStyle.copyWith(
                        fontSize: 12, fontWeight: medium),
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
      child: const Align(
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
      child: const Align(
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

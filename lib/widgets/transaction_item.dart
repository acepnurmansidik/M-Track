import 'package:flutter/material.dart';
import 'package:tracking/pages/success_page.dart';
import 'package:tracking/pages/transaction_page.dart';
import 'package:tracking/theme.dart';

class TransactionItem extends StatelessWidget {
  final bool grafik;
  final String type;
  final String name;
  const TransactionItem(
      {super.key,
      required this.grafik,
      required this.type,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/add-transaction');
      },
      child: Dismissible(
        key: Key("value"),
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
                      type,
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium),
                    ),
                    Text(
                      name,
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
                    "200.000",
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: medium),
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

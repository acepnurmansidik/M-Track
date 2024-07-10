import 'package:flutter/material.dart';
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
    return Container(
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
                  type,
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
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
                style:
                    blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
              ),
            ],
          )
        ],
      ),
    );
  }
}

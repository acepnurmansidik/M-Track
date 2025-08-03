import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final bool isIncome;
  final int nominal;
  final String datetime;

  const TransactionItem({
    super.key,
    required this.nominal,
    required this.datetime,
    required this.title,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: kBaseColors,
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/debt.png'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width - 97,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title),
                        Text(
                          '${isIncome ? "+" : "-"}${formatRupiah(nominal)}',
                          style: blackTextStyle.copyWith(
                            fontWeight: semibold,
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
                          'Today, 10:30 AM',
                          style: greyTextStyle.copyWith(fontSize: 12),
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
    );
  }
}

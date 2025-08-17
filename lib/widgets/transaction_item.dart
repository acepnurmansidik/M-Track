import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String isIncome;
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
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width - 104,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        Text(
                          '${isIncome == "income" ? "+" : "-"}${formatRupiah(nominal)}',
                          style: blackTextStyle.copyWith(
                            fontWeight: light,
                            color:
                                isIncome == "income" ? kGreenColor : kRedColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          datetime,
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

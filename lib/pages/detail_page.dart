import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tracking/model/transaction_model.dart';
import 'package:tracking/theme.dart';

class DetailPage extends StatelessWidget {
  final bool grafik = false;
  final TransactionModel transaction;

  const DetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    Widget appBarSection() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left,
                color: kBlackColor,
              ),
            )
          ],
        ),
      );
    }

    Widget detailInfo() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 25),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(18)),
        child: Column(children: [
          Icon(
            Icons.train,
            size: 45,
            color: kBlueColor,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Transport',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          Text.rich(TextSpan(
              text: "20 Dec, 2024",
              style: greyTextStyle.copyWith(fontSize: 12, fontWeight: light),
              children: const [
                TextSpan(text: " | "),
                TextSpan(text: "09:30")
              ])),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
                Text(
                    NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                        .format(transaction.amount),
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: medium))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
              Transform.rotate(
                angle: grafik ? 0.7854 : -0.7854,
                child: Icon(
                  grafik ? Icons.arrow_upward : Icons.arrow_downward,
                  color: grafik ? kGreenColor : kRedColor,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(),
                ),
                Container(
                  height: 220,
                  width: 220,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img_qrcode.png"))),
                )
              ],
            ),
          )
        ]),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      body: ListView(
        children: [detailInfo()],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kGreenColor
      ..strokeWidth = 2;

    double dashWidth = 5;
    double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

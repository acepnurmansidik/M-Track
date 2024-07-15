import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/theme.dart';

class DetailPage extends StatelessWidget {
  final bool grafik = false;
  final TrxItemModel transaction;

  const DetailPage({
    super.key,
    required this.transaction,
  });

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

    Widget noteSection() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(lineColor: kGreyColor),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note *",
                    style: greyTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "transaction.note",
                    style: greyTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget qrCodeSection() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(
                  lineColor: kGreenColor, spaceLine: 7, strokeLine: 2),
            ),
            Container(
              height: 220,
              width: 220,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img_qrcode.png"))),
            )
          ],
        ),
      );
    }

    Widget detailInfo() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 25),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(18)),
        child: Column(children: [
          Icon(
            Icons.train,
            size: 45,
            color: kBlueColor,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            transaction.categoryId["value"],
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          Text(
            transaction.datetime,
            style: greyTextStyle.copyWith(fontSize: 12, fontWeight: light),
          ),

          // LIST ITEM INFO
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.typeId["value"],
                  style:
                      greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
                Transform.rotate(
                  angle: transaction.isIncome ? 0.7854 : -0.7854,
                  child: Icon(
                    transaction.isIncome
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: transaction.isIncome ? kGreenColor : kRedColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "exchange rate",
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
              Text(
                transaction.kursId["description"],
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "current exchange rate",
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
              Text(
                NumberFormat.currency(symbol: "", decimalDigits: 0)
                    .format(transaction.kursAmount),
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "amount",
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
              Text(
                NumberFormat.currency(symbol: "", decimalDigits: 0)
                    .format(transaction.amount),
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
            ],
          ),

          // TOTAL AMOUNT
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
                Text(
                    NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                        .format(transaction.totalAmount),
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: medium))
              ],
            ),
          ),
          noteSection(),
          qrCodeSection()
        ]),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60), child: appBarSection()),
      body: ListView(
        children: [detailInfo()],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color lineColor;
  final double spaceLine;
  final double strokeLine;

  DashedLinePainter(
      {required this.lineColor, this.spaceLine = 0, this.strokeLine = 0.3});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeLine;

    double dashWidth = 7;
    double dashSpace = spaceLine;
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

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        backgroundColor: kWhiteColor,
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
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPaint(
              size: const Size(double.infinity, 1),
              painter: DashedLinePainter(lineColor: kGreyColor),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note *",
                    style: greyTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    transaction.note,
                    style: greyTextStyle.copyWith(
                        fontSize: 12, fontWeight: medium),
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
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          children: [
            CustomPaint(
              size: const Size(double.infinity, 2),
              painter: DashedLinePainter(
                  lineColor: kGreyColor, spaceLine: 7, strokeLine: 1.7),
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
      );
    }

    Widget detailInfo() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 25),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.network(
                '${dotenv.env["PUBLIC_API_BASE_IMAGE"]}${transaction.categoryId["icon"]["name"]}'),
          ),
          const SizedBox(
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
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.typeId["value"],
                  style:
                      greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${dotenv.env["PUBLIC_API_BASE_IMAGE"]}${transaction.typeId["icon"]["name"]}',
                        ),
                      )),
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
                transaction.kursId["value"],
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
            margin: const EdgeInsets.only(top: 10),
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
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      body: ListView(
        children: [
          detailInfo(),
        ],
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

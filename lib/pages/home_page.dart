import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/transaction_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget balanceInfo() {
      return Container(
        height: 250,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/img_avatar.png"))),
                ),
                Container(
                  height: 40,
                  width: 95,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.qr_code_scanner_outlined),
                      Container(
                        height: 20,
                        width: 2,
                        decoration: BoxDecoration(color: kGreyColor),
                      ),
                      Icon(Icons.notification_add_outlined)
                    ],
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(bottom: 5, top: 20),
                child: Text(
                  "Current value",
                  style: greyTextStyle.copyWith(fontSize: 16),
                )),
            Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text.rich(TextSpan(
                    text: 'Rp ',
                    style: blackTextStyle.copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                          text: "15.534",
                          style: blackTextStyle.copyWith(
                              fontSize: 35, fontWeight: extraBold))
                    ]))),
            Text.rich(TextSpan(
                text: '+1.0000',
                style: blackTextStyle.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                      text: " 25.9%",
                      style: greenTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium))
                ])),
          ],
        ),
      );
    }

    Widget transactionList() {
      return SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.65,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(18))),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          TransactionItem(
                              grafik: true, type: 'type', name: 'name'),
                          TransactionItem(
                              grafik: true, type: 'type', name: 'name'),
                          TransactionItem(
                              grafik: true, type: 'type', name: 'name'),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 5,
                        width: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: kDoveGreyColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(color: kWhiteColor),
                        child: Row(
                          children: [
                            Text(
                              "Transaksi",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semibold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
      ;
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Image.asset(
            "assets/img_background.png",
            color: kSecondGreyColor,
            width: double.infinity,
          ),
          balanceInfo(),
          transactionList(),
        ],
      ),
      bottomNavigationBar: Container(
        width: 400,
        height: 70,
        decoration: BoxDecoration(
            color: kWhiteColor,
            border: Border(top: BorderSide(width: 0.2, color: kGreyColor))),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-transaction');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: kGreenColor, style: BorderStyle.solid),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: kGreenColor,
                  size: 30,
                ),
              ),
              Text(
                "Add",
                style:
                    greenTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

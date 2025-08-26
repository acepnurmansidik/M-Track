// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element, must_be_immutable, deprecated_member_use, non_const_call_to_literal_constructor

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class DetailTransactionPage extends StatefulWidget {
  String title;
  DetailTransactionPage({super.key, required this.title});

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: kSecondBaseColor,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          _informationSection(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      surfaceTintColor: kSecondBaseColor,
      backgroundColor: kSecondBaseColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              toTitleCase("Detail transaction"),
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _informationSection() {
    Widget _detailItem(String title, dynamic subtitle, bool isLastItem) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color:
                  isLastItem ? Colors.transparent : kGreyColor.withOpacity(.3),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                color: kGreyColor,
              ),
            ),
            Text(
              subtitle,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
      margin: EdgeInsets.all(defaultMargin),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/${widget.title}.png'),
                      colorFilter: ColorFilter.mode(
                        kPrimaryV2Color,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Text(
                  formatCurrency(400000),
                  style: blackTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  toTitleCase(widget.title),
                  style: greyTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
          _detailItem("Transaction ID", "DBS5675SD", false),
          _detailItem("Type", "Income", false),
          _detailItem("Date", "25 Aug, 2025, 10:24 AM", false),
          _detailItem("Total", formatCurrency(400000), true),
          Container(
            padding: const EdgeInsets.all(20),
            child: PrettyQr(
              data: 'ad8asy9dasd',
              size: 150,
              roundEdges: true,
              elementColor: kPrimaryV2Color,
              typeNumber: 6,
              errorCorrectLevel: QrErrorCorrectLevel.M,
              // Logo di tengah QR code
              image: const AssetImage('assets/img_logo.png'),
            ),
          )
        ],
      ),
    );
  }
}

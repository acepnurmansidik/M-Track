// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element, must_be_immutable, deprecated_member_use, non_const_call_to_literal_constructor

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class DetailTransactionPage extends StatefulWidget {
  String title = '';
  String transactionId = '';
  String type = '';
  String date = '';
  String currency = '';
  String notes = '';
  int totalAmount = 0;
  DetailTransactionPage({
    super.key,
    this.title = '',
    this.transactionId = '',
    this.type = '',
    this.date = '',
    this.totalAmount = 0,
    this.currency = 'idr',
    this.notes = '',
  });

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
    Widget _detailItem(String title, dynamic subtitle) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: kGreyColor.withOpacity(.3),
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
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/${widget.title.replaceAll(" ", "").toLowerCase()}.png'),
                      colorFilter: ColorFilter.mode(
                        kPrimaryV2Color,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Text(
                  formatCurrency(widget.totalAmount),
                  style: blackTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 18,
                    color: widget.type.toLowerCase() == "income"
                        ? kGreenColor
                        : kRedColor,
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
          _detailItem(
            "Transaction ID",
            truncateWithEllipsis(text: widget.transactionId, cutoff: 17),
          ),
          _detailItem("Type", toTitleCase(widget.type)),
          _detailItem("Date", widget.date),
          _detailItem("Currency", widget.currency.toUpperCase()),
          _detailItem("Total", formatCurrency(widget.totalAmount)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.transparent,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notes:",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        color: kGreyColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.notes,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: PrettyQr(
              data: widget.transactionId,
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

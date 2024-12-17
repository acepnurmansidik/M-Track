import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/pages/form_transaction_page.dart';
import 'package:tracking/skelaton/skelaton_trx_list.dart';
import 'package:tracking/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/widgets/custom_buttom_navbar.dart';
import 'package:tracking/widgets/transaction_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isActive = false;
  int _timeCount = 5;
  Timer? _timer;
  String idTrx = "";

  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget customBtnNav() {
      return Container(
        width: 400,
        height: 70,
        decoration: BoxDecoration(
            color: kWhiteColor,
            border: Border(top: BorderSide(width: 0.2, color: kGreyColor))),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => const TransactionPage(
                //   isEditBtn: false,
                // ),
                builder: (context) => const FormTransactionPage(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
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
      );
    }

    Widget balanceInfo(TransactionModel dataTrx) {
      return Container(
        height: 250,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/setting');
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/img_avatar.png"))),
                  ),
                ),
                Container(
                  height: 40,
                  width: 95,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.qr_code_scanner_outlined),
                      Container(
                        height: 20,
                        width: 2,
                        decoration: BoxDecoration(color: kGreyColor),
                      ),
                      const Icon(Icons.notification_add_outlined)
                    ],
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, top: 20),
                child: Text(
                  "Current balance",
                  style: greyTextStyle.copyWith(fontSize: 16),
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text.rich(TextSpan(
                    text: 'Rp ',
                    style: blackTextStyle.copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                          text: NumberFormat.currency(
                                  symbol: "", decimalDigits: 0)
                              .format(dataTrx.currentMonthly),
                          style: blackTextStyle.copyWith(
                              fontSize: 35, fontWeight: extraBold))
                    ]))),
            Text.rich(TextSpan(
                text: NumberFormat.currency(symbol: "", decimalDigits: 0)
                    .format(dataTrx.grandTotal),
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

    Widget transactionList(List<ListDataTransactionModel> listData) {
      final List<Widget> result;
      if (listData.isNotEmpty) {
        result = listData.map((subItems) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(color: kGreyColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subItems.id,
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: semibold),
                        ),
                        Text(
                          NumberFormat.currency(
                                  symbol: "IDR ", decimalDigits: 0)
                              .format(subItems.totalMonthly),
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: semibold),
                        ),
                      ],
                    )),
                Column(
                  children: subItems.items.map((item) {
                    return TransactionItem(
                        grafik: false,
                        transaction: item,
                        cancelBtn: (value, id) {
                          setState(() {
                            isActive = value;
                            idTrx = id;
                          });
                        });
                  }).toList(),
                )
              ],
            ),
          );
        }).toList();
      } else {
        List<Widget> widgets = [
          Center(
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icon_notfound.png"))),
              ),
              Text(
                "Aww...you have'nt\ntransaction",
                style:
                    blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
                textAlign: TextAlign.center,
              )
            ]),
          )
        ];

        result = widgets;
      }

      return SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.65,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: result,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 5,
                        width: 50,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: kDoveGreyColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18))),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 15,
                            left: defaultMargin,
                            right: defaultMargin),
                        decoration: BoxDecoration(color: kWhiteColor),
                        child: Row(
                          children: [
                            Text(
                              "Transactions",
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
    }

    Widget cancelButton() {
      _timer = Timer(const Duration(seconds: 1), () {
        if (_timeCount == 1) {
          setState(() {
            isActive = false;
            _timeCount = 5;
            context.read<TransactionCubit>().deleteTrx(idTrx);
          });
        } else {
          setState(() {
            _timeCount -= 1;
          });
        }
      });
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 45,
          margin: EdgeInsets.only(
              left: defaultMargin, right: defaultMargin, bottom: 25),
          padding:
              EdgeInsets.only(left: defaultMargin, right: defaultMargin - 10),
          decoration: BoxDecoration(
              color: kBackgroundNotifColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: kWhiteColor,
                          strokeWidth: 2.5,
                          // value: _timeCount,
                        ),
                        Text(
                          '$_timeCount',
                          style: whiteTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "click for cancel",
                    style: whiteTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _timeCount = 5;
                    isActive = false;
                    _timer?.cancel();
                  });
                },
                child: Text(
                  "Undo",
                  style: darkBlueTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Stack(
              children: [
                Image.asset(
                  "assets/img_background.png",
                  color: kSecondGreyColor,
                  width: double.infinity,
                ),
                balanceInfo(TransactionModel(
                    grandTotal: 0, currentMonthly: 0, listData: [])),
                const SkelatonTrxList(),
                isActive ? cancelButton() : const SizedBox(),
              ],
            );
          } else if (state is TransactionSuccess) {
            return Stack(
              children: [
                Image.asset(
                  "assets/img_background.png",
                  color: kSecondGreyColor,
                  width: double.infinity,
                ),
                balanceInfo(state.transactions),
                transactionList(state.transactions.listData),
                isActive ? cancelButton() : const SizedBox(),
              ],
            );
          }
          return Stack(
            children: [
              Image.asset(
                "assets/img_background.png",
                color: kSecondGreyColor,
                width: double.infinity,
              ),
              balanceInfo(TransactionModel(
                  grandTotal: 0, currentMonthly: 0, listData: [])),
              transactionList([]),
              isActive ? cancelButton() : const SizedBox(),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomButtomNavbar(),
    );
  }
}

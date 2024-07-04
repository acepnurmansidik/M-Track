import 'package:flutter/material.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/transaction_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget balanceInfo() {
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                margin: const EdgeInsets.only(bottom: 5, top: 20),
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
            Container(
                child: Text.rich(TextSpan(
                    text: '+1.0000',
                    style: blackTextStyle.copyWith(fontSize: 16),
                    children: [
                  TextSpan(
                      text: " 25.9%",
                      style: greenTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium))
                ]))),
          ],
        ),
      );
    }

    Widget transactionList() {
      return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: CircularProgressIndicator(),
            );
          } else if (state is TransactionSuccess) {
            final response = state.transactions.length != 0
                ? state.transactions
                    .map((transaction) => TransactionItem(
                          transaction: transaction,
                        ))
                    .toList()
                : [
                    Center(
                        child: Container(
                      height: 210,
                      width: 210,
                      margin: const EdgeInsets.only(top: 50),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icon_notfound.png"))),
                    ))
                  ];
            return SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.65,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(18))),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: response,
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
          }
          return Container();
        },
      );
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
      bottomNavigationBar: GestureDetector(
        child: Container(
          decoration: BoxDecoration(color: kWhiteColor),
          width: double.infinity,
          height: 70,
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
      ),
    );
  }
}

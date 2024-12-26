import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking/theme.dart';

class BankAccountPage extends StatelessWidget {
  const BankAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Acep Nurman Sidik",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Welcome back",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 28,
              width: 28,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/stopwatch.png'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget virtualCard() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width - 55,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: const EdgeInsets.only(bottom: 20, right: 20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/visa.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/triple-dot.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NumberFormat.currency(symbol: "\$ ", decimalDigits: 0)
                            .format(5235700),
                        style: TextStyle(fontSize: 32, fontWeight: bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Virtual Number ID',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '2038 6756 7788 1524 0173',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semibold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                            width: 60,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Opacity(
                                  opacity: .7,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kGreenColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width - 55,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/plus.png'),
                      ),
                    ),
                  ),
                  Text(
                    'Add Card',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget recentActiviy() {
      Widget activityItem({title, nominal, type, date}) {
        return Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kWhiteColor,
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cash_out.png'),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                  NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                      .format(nominal),
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ))
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Recent Activity",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            Column(
              children: [
                activityItem(
                  title: "Top Up Gopay",
                  date: "20",
                  nominal: 50000,
                  type: "cash-out",
                ),
                activityItem(
                  title: "Top Up Gopay",
                  date: "20",
                  nominal: 50000,
                  type: "cash-out",
                ),
                activityItem(
                  title: "Top Up Gopay",
                  date: "20",
                  nominal: 50000,
                  type: "cash-out",
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget totalSummary() {
      Widget totalSummaryItem({
        String title = "",
        int nominal = 0,
        String percent = "",
      }) {
        return Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: (MediaQuery.of(context).size.width / 2) - 47,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                NumberFormat.currency(
                  symbol: "",
                  decimalDigits: 0,
                ).format(nominal),
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semibold,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 60,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: kGreenColor.withOpacity(.3),
                ),
                child: Text(
                  "+$percent %",
                  style: greenTextStyle.copyWith(fontSize: 14),
                ),
              )
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Total In & Out",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      totalSummaryItem(
                        title: "In",
                        nominal: 150000000,
                        percent: "50",
                      ),
                      Container(
                        height: 70,
                        width: 1,
                        decoration:
                            BoxDecoration(color: kGreyColor.withOpacity(.2)),
                      ),
                      totalSummaryItem(
                        title: "Out",
                        nominal: 500000,
                        percent: "50",
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return ListView(
      children: [
        appBar(),
        virtualCard(),
        totalSummary(),
        recentActiviy(),
      ],
    );
  }
}

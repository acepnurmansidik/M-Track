import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/transaction_item.dart';

class OrderDetailCategoryPage extends StatelessWidget {
  const OrderDetailCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appBarSection() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kBaseColors,
        surfaceTintColor: kBaseColors,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.chevron_left, color: Colors.black),
                ),
              ),
              Expanded(
                // <-- Biarkan teks mengambil sisa ruang
                child: Text(
                  'Order Details',
                  textAlign: TextAlign.center, // <-- Pusatkan teks
                  style: blackTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
      );
    }

    Widget titleSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              const TextSpan(children: [
                TextSpan(text: "Spending · "),
                TextSpan(text: "Augt 2025"),
              ]),
              style: greyTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              formatRupiah(195000000),
              style:
                  blackTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
            )
          ],
        ),
      );
    }

    Widget barChartSection() {
      return Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 30),
        color: kRedColor,
      );
    }

    Widget cashflowSection() {
      Widget cashflowItem(bool isIncome, String title, int amount) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 2.23,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isIncome ? Colors.green[50] : Colors.red[50],
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: isIncome ? Colors.green[500] : Colors.red[500],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatRupiah(amount),
                    style: greenTextStyle.copyWith(
                      color: isIncome ? Colors.green[300] : Colors.red[300],
                    ),
                  ),
                  Text(
                    title,
                    style: greyTextStyle,
                  ),
                ],
              )
            ],
          ),
        );
      }

      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cashflowItem(true, "Income", 100000),
            cashflowItem(false, "Spending", 20000),
          ],
        ),
      );
    }

    Widget transactionListSection() {
      return const Column(
        children: [
          TransactionItem(
            title: 'Food & Drink',
            datetime: "Today, 10:30 AM",
            nominal: 10000,
            isIncome: false,
          ),
          TransactionItem(
            title: 'Salary Monthly',
            datetime: "Today, 08:30 AM",
            nominal: 7000000,
            isIncome: true,
          ),
          TransactionItem(
            title: 'Salary Monthly',
            datetime: "Today, 08:30 AM",
            nominal: 7000000,
            isIncome: true,
          ),
          TransactionItem(
            title: 'Salary Monthly',
            datetime: "Today, 08:30 AM",
            nominal: 7000000,
            isIncome: true,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      backgroundColor: kBaseColors,
      body: ListView(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: 20,
        ),
        children: [
          titleSection(),
          barChartSection(),
          cashflowSection(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Pocket',
                  style: greyTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          transactionListSection(),
        ],
      ),
    );
  }
}

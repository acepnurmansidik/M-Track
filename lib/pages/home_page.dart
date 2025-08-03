import 'package:flutter/material.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/transaction_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isActive = false;
  double scrollOffset = 0.0; // Menyimpan offset scroll
  String selectedMenu = "All";

  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransaction();
    super.initState();
  }

  void handleChange(menu) {
    setState(() {
      selectedMenu = menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget collapseHeader() {
      Widget headerItem(String title, IconData icon) {
        return Container(
          height: 32,
          margin: const EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: kPrimaryV2Color,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: kBaseColors,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  color: kBaseColors,
                  fontWeight: medium,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        color: kBaseColors,
        padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your balance',
              style: greyTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              '62.3233',
              style: blackTextStyle.copyWith(
                fontSize: 38,
                fontWeight: semibold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  headerItem('Request', Icons.add_card),
                  headerItem('Transfer', Icons.send),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget backgroundHeader() {
      Widget balanceInfo(bool isActive) {
        Widget headerItem(String title, IconData icon) {
          return Container(
            height: 35,
            margin: const EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: kPrimaryV2Color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: kBaseColors,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(color: kBaseColors, fontWeight: medium),
                ),
              ],
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your balance',
                style: greyTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                '62.3233',
                style: blackTextStyle.copyWith(
                  fontSize: 38,
                  fontWeight: semibold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    headerItem('Request', Icons.add_card),
                    headerItem('Transfer', Icons.send),
                    Container(
                      height: 35,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kThirdColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        color: kBlackColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }

      Widget headerTitle() {
        return Container(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryV2Color,
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[100],
                    ),
                    child: Image.asset('assets/notif.png'),
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.only(top: 5, left: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kRedColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }

      return Container(
        color: kBaseColors,
        child: Column(
          children: [
            headerTitle(),
            balanceInfo(false),
          ],
        ),
      );
    }

    Widget transactionHistorySection() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: greyTextStyle,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(color: kPrimaryV2Color),
                  ),
                ),
              ],
            ),
            // Contoh konten container
            const Column(
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
              ],
            )
          ],
        ),
      );
    }

    Widget categorySection() {
      Widget categoryItem(String title, double leftSpacing) {
        return GestureDetector(
          onTap: () {
            handleChange(title);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.only(right: 7, left: leftSpacing),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: selectedMenu == title ? kPrimaryV2Color : Colors.grey[100],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: selectedMenu == title ? semibold : medium,
                color: selectedMenu == title ? kWhiteColor : kBlackColor,
                fontSize: 13,
              ),
            ),
          ),
        );
      }

      Widget categoryGridItem() {
        return Container(
          height: 150,
          width: 165,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: kBaseColors,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.08), // Warna shadow dengan opacity
                spreadRadius: .5, // Seberapa jauh shadow menyebar
                blurRadius: 15, // Seberapa blur shadow
                offset: const Offset(0, 0), // Posisi shadow (x, y)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                  child: Column(
                children: [
                  Icon(
                    Icons.local_drink_outlined,
                    size: 40,
                  ),
                ],
              )),
              Text(
                'Food & Drink',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              Text(
                formatRupiah(3000),
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Mengatur scroll ke arah horizontal
                child: Row(
                  children: [
                    categoryItem('All', 10),
                    categoryItem('Investment', 0),
                    categoryItem('Savings', 0),
                    categoryItem('Expenses', 0),
                    categoryItem('Income', 0),
                    categoryItem('Loans', 0),
                    categoryItem('Insurance', 0),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      categoryGridItem(),
                      categoryGridItem(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      categoryGridItem(),
                      categoryGridItem(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        setState(() {
          if (scrollInfo.metrics.axis.name != "horizontal") {
            scrollOffset = scrollInfo.metrics.pixels; // Update scroll offset
          }
        });
        return true;
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 140,
            expandedHeight: 210,
            backgroundColor: kBaseColors,
            surfaceTintColor: kBaseColors,
            flexibleSpace: FlexibleSpaceBar(
              background: backgroundHeader(),
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              title: Opacity(
                opacity:
                    (scrollOffset / 100).clamp(0.0, 1.0), // Mengatur opacity
                child: Transform.translate(
                  offset: Offset(
                    0,
                    100 * (1 - (scrollOffset / 100).clamp(0.0, 1)),
                  ), // Mengatur posisi vertikal
                  child: collapseHeader(),
                ),
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                transactionHistorySection(),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 10,
                  ),
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
                categorySection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

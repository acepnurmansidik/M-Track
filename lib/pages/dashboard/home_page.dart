// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/detail_category_page.dart';
import 'package:tracking/theme.dart';
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

  ScrollController controllerTransactionList =
      ScrollController(); // Controller untuk filter section
  ScrollController controllerMain = ScrollController();
  ScrollController controllerFilterCategory = ScrollController();

  @override
  void initState() {
    context.read<TransactionCubit>().fetchGroupCategories();
    super.initState();
  }

  void handleChange(menu) {
    setState(() {
      selectedMenu = menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    Route createRoute(targetPage) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Mulai dari kanan
          const end = Offset.zero; // Berhenti di posisi normal
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
    }

    // NOTES: BALANCE & LAST TRANSACTION THIS MONTH
    Widget headerSection() {
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

      return SliverAppBar(
        collapsedHeight: 140,
        expandedHeight: 210,
        backgroundColor: kBaseColors,
        surfaceTintColor: kBaseColors,
        flexibleSpace: FlexibleSpaceBar(
          background: backgroundHeader(),
          collapseMode: CollapseMode.parallax,
          centerTitle: true,
          title: Opacity(
            opacity: (scrollOffset / 100).clamp(0.0, 1.0), // Mengatur opacity
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
      );
    }

    // NOTES: FILTER CATEGORY
    Widget categoriesFilterSection() {
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
              SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  controller: controllerTransactionList,
                  child: const Column(
                    children: [
                      TransactionItem(
                        title: 'Food & Drink',
                        datetime: "Today, 10:30 AM",
                        nominal: 10000,
                        isIncome: "income",
                      ),
                      TransactionItem(
                        title: 'Salary Monthly',
                        datetime: "Today, 08:30 AM",
                        nominal: 7000000,
                        isIncome: "expense",
                      ),
                      TransactionItem(
                        title: 'Salary Monthly',
                        datetime: "Today, 08:30 AM",
                        nominal: 7000000,
                        isIncome: "expense",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget filterSection() {
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
                color:
                    selectedMenu == title ? kPrimaryV2Color : Colors.grey[100],
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

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  controller: controllerFilterCategory,
                  scrollDirection:
                      Axis.horizontal, // Mengatur scroll ke arah horizontal
                  child: Row(
                    children: [
                      categoryItem('All', 20),
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
            ],
          ),
        );
      }

      return SliverList(
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
            filterSection(),
          ],
        ),
      );
    }

    // NOTES: CATEGORY
    Widget categoriesItemSection() {
      Widget categoryGridItem(CategoryDaum data) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(createRoute(DetailCategoryPage(title: data.category)));
          },
          child: Container(
            height: 150,
            width: 165,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kBaseColors,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: .5,
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/${data.category.replaceAll(" ", "").toLowerCase()}_pulsar.png"),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  toTitleCase(
                      data.category), // Ganti dengan nama kategori dari model
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                Text(
                  formatRupiah(
                      data.totalAmount), // Ganti dengan jumlah dari model
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SliverPadding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: 30,
        ),
        sliver: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is TransactionSuccess) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return categoryGridItem(
                        (state.categoryTransaction as CategoriesModelProps)
                            .data[index]); // Pass the category object
                  },
                  childCount:
                      (state.categoryTransaction as CategoriesModelProps)
                          .data
                          .length,
                ),
              );
            } else if (state is TransactionFailed) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text('Error: ${state.error}'),
                ),
              );
            }
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('No categories available'),
              ),
            );
          },
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        return true;
      },
      child: CustomScrollView(
        controller: controllerMain,
        slivers: [
          // NOTES: BALANCE & LAST TRANSACTION THIS MONTH
          headerSection(),
          // NOTES: FILTER CATEGORY
          categoriesFilterSection(),
          // NOTES: CATEGORY
          categoriesItemSection()
        ],
      ),
    );
  }
}

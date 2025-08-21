// ignore_for_file: unnecessary_cast, no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';
import 'package:tracking/pages/dashboard/detail_category_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/errors_item/transaction_item_failed.dart';
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
    context.read<TransactionCubit>().fetchInitiate();
    super.initState();
  }

  void handleChange(menu) {
    setState(() {
      selectedMenu = menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        setState(() {
          // Mendapatkan label dari GlobalKey
          if (scrollInfo.metrics.axis.name != "horizontal") {
            scrollOffset = scrollInfo.metrics.pixels; // Update scroll offset
          }
        });
        return true;
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      controller: controllerMain,
      slivers: [
        // NOTES: BALANCE & LAST TRANSACTION THIS MONTH
        _headerSection(),
        // NOTES: FILTER CATEGORY
        _categoriesFilterSection(),
        // NOTES: CATEGORY
        _categoriesItemSection()
      ],
    );
  }

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

  // NOTES: HEADER
  Widget _headerSection() {
    Widget _balanceInfoSection({bool isCollapse = false}) {
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
                style: TextStyle(
                  color: kBaseColors,
                  fontWeight: medium,
                  fontSize: isCollapse ? 14 : 16,
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        color: kBaseColors,
        padding: EdgeInsets.only(top: isCollapse ? 35 : 25, left: 20),
        child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
          if (state is WalletLoading) {
          } else if (state is WalletSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your balance',
                      style: greyTextStyle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        state.userWallets.walletName,
                        style: greyTextStyle.copyWith(
                          fontSize: 10,
                          color: kGreenColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  formatCurrency(state.userWallets.amount),
                  style: blackTextStyle.copyWith(
                    fontSize: isCollapse ? 38 : 40,
                    fontWeight: semibold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 9),
                  child: Row(
                    children: [
                      headerItem('Request', Icons.add_card),
                      headerItem('Transfer', Icons.send),
                      isCollapse
                          ? const SizedBox()
                          : Container(
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
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Your balance',
                    style: greyTextStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '62.3233',
                style: blackTextStyle.copyWith(
                  fontSize: isCollapse ? 38 : 40,
                  fontWeight: semibold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    headerItem('Request', Icons.add_card),
                    headerItem('Transfer', Icons.send),
                    isCollapse
                        ? const SizedBox()
                        : Container(
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
          );
        }),
      );
    }

    Widget _titleSection() {
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

    return SliverAppBar(
      collapsedHeight: 140,
      expandedHeight: 210,
      backgroundColor: kBaseColors,
      surfaceTintColor: kBaseColors,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: kBaseColors,
          child: Column(
            children: [
              _titleSection(),
              _balanceInfoSection(),
            ],
          ),
        ),
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        title: Opacity(
          opacity: (scrollOffset / 100).clamp(0.0, 1.0), // Mengatur opacity
          child: Transform.translate(
            offset: Offset(
              0,
              100 * (1 - (scrollOffset / 100).clamp(0.0, 1)),
            ), // Mengatur posisi vertikal
            child: _balanceInfoSection(isCollapse: true),
          ),
        ),
      ),
      pinned: true,
    );
  }

  // NOTES: FILTER CATEGORY
  Widget _categoriesFilterSection() {
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
              child: BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                  } else if (state is TransactionSuccess) {
                    return Column(
                      children: state.listItemTransaction.data.isNotEmpty
                          ? state.listItemTransaction.data
                              .asMap()
                              .entries
                              .map((everyItem) {
                              if (everyItem.key <= 1) {
                                return TransactionItem(
                                  title:
                                      toTitleCase(everyItem.value.categoryName),
                                  datetime: everyItem.value.date,
                                  nominal: everyItem.value.totalAmount,
                                  isIncome: everyItem.value.typeName,
                                );
                              }
                              return const SizedBox();
                            }).toList()
                          : [
                              SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 115,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/empty-box.png'),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Aww... there's not transaction",
                                      style: blackTextStyle.copyWith(
                                          fontWeight: medium),
                                    )
                                  ],
                                ),
                              )
                            ],
                    );
                  }
                  return Column(
                    children: [
                      TransactionItemFailed(isIncome: true),
                      TransactionItemFailed(isIncome: false),
                    ],
                  );
                },
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
                    // categoryItem('Investment', 0),
                    // categoryItem('Savings', 0),
                    categoryItem('Expense', 0),
                    categoryItem('Income', 0),
                    // categoryItem('Loans', 0),
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
                  'Category',
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
  Widget _categoriesItemSection() {
    Widget _categoryGridItem(CategoryDaum data) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            createRoute(
              DetailCategoryPage(
                title: data.category,
                typeName: data.typeName,
              ),
            ),
          );
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
            // Ambil data kategori
            final categories = selectedMenu == "All"
                ? (state.categoryTransaction as CategoriesModelProps).data
                : (state.categoryTransaction as CategoriesModelProps)
                    .data
                    .where((itemSearch) =>
                        itemSearch.typeName == selectedMenu.toLowerCase())
                    .toList();

            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // Pastikan untuk mengakses elemen yang benar dari filteredCategories
                  return _categoryGridItem(
                      categories[index]); // Pass the category object
                },
                childCount: categories.length,
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
}

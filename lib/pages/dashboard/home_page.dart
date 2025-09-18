// ignore_for_file: unnecessary_cast, no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/user/user_cubit.dart';
import 'package:tracking/failed_item/balance_info_failed.dart';
import 'package:tracking/failed_item/transaction_item_failed.dart';
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';
import 'package:tracking/pages/dashboard/detail_category_page.dart';
import 'package:tracking/pages/form/cashflow/form_cashflow_page.dart';
import 'package:tracking/skelaton/balance_info_loading.dart';
import 'package:tracking/skelaton/category_box_loading.dart';
import 'package:tracking/skelaton/transaction_square_loading.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/custom_widget.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/category_error_item.dart';
import 'package:tracking/widgets/notification_navigation_item.dart';
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

  // NOTES: HEADER
  Widget _headerSection() {
    const collapsedHeight = 140.0;
    const expandedHeight = 210.0;

    Widget headerItem(String title, IconData icon, VoidCallback onTap,
        {bool isCollapse = false}) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 35,
          margin: const EdgeInsets.only(right: 8),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 2),
          decoration: BoxDecoration(
            color: kPrimaryV2Color,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: kBaseColors),
              const SizedBox(width: 5),
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
        ),
      );
    }

    Widget balanceInfoSection({bool isCollapse = false}) {
      return Container(
        color: kBaseColors,
        padding: EdgeInsets.only(top: isCollapse ? 35 : 25, left: 20),
        child: BlocBuilder<WalletCubit, WalletState>(
          buildWhen: (prev, curr) => curr is! WalletLoading,
          builder: (context, state) {
            if (state is WalletLoading) {
              return BalanceInfoLoading(isCollapse: isCollapse);
            } else if (state is WalletSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Your balance',
                          style: greyTextStyle.copyWith(fontSize: 15)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          state.walletSelected.walletName,
                          style: greyTextStyle.copyWith(
                              fontSize: 10, color: kGreenColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatCurrency(state.walletSelected.amount),
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                      fontSize: isCollapse ? 38 : 40,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      headerItem('Request', Icons.add_card, () {
                        Navigator.push(
                          context,
                          createRoute(const FormCashflowPage()),
                        );
                      }),
                      headerItem('Transfer', Icons.send, () {}),
                      if (!isCollapse)
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: kThirdColor,
                          child: Icon(Icons.more_horiz, color: kBlackColor),
                        ),
                    ],
                  ),
                ],
              );
            }
            return BalanceInfoFailed(isCollapse: isCollapse);
          },
        ),
      );
    }

    Widget titleSection() {
      return Padding(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      formatEmptyProfile(state.userProfile.data.name),
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semibold,
                        color: kPrimaryV2Color.withOpacity(.9),
                      ),
                    ),
                  );
                }
                return const CircleAvatar(radius: 20);
              },
            ),
            NotificationNavigationItem(isShowNotif: false),
          ],
        ),
      );
    }

    return SliverAppBar(
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      backgroundColor: kBaseColors,
      surfaceTintColor: kBaseColors,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            titleSection(),
            balanceInfoSection(),
          ],
        ),
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        title: Opacity(
          opacity: (scrollOffset / 100).clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(
              0,
              100 * (1 - (scrollOffset / 100).clamp(0.0, 1)),
            ),
            child: balanceInfoSection(isCollapse: true),
          ),
        ),
      ),
    );
  }

  // ---------------- FILTER CATEGORY ----------------
  Widget _categoriesFilterSection() {
    Widget categoryItem(String title, double leftSpacing) {
      final isSelected = selectedMenu == title;
      return GestureDetector(
        onTap: () => setState(() => selectedMenu = title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: 7, left: leftSpacing),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryV2Color : Colors.grey[100],
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: isSelected ? semibold : medium,
              color: isSelected ? kWhiteColor : kBlackColor,
              fontSize: 13,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _transactionHistorySection(),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
            child:
                Text('Category', style: greyTextStyle.copyWith(fontSize: 16)),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              controller: controllerFilterCategory,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryItem('All', 20),
                  categoryItem('Expense', 0),
                  categoryItem('Income', 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionHistorySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transactions', style: greyTextStyle),
                TextButton(
                  onPressed: () {},
                  child:
                      Text('See All', style: TextStyle(color: kPrimaryV2Color)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Column(
                    children: [
                      TransactionSquareLoading(),
                      TransactionSquareLoading()
                    ],
                  );
                } else if (state is TransactionSuccess) {
                  final items = state.listItemTransaction.data;
                  if (items.isEmpty) {
                    return Column(
                      children: [
                        Container(
                          height: 115,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/empty-box.png'),
                            ),
                          ),
                        ),
                        Text("Aww... there's no transaction",
                            style: blackTextStyle.copyWith(fontWeight: medium)),
                      ],
                    );
                  }
                  return Column(
                    children: items.take(2).map((item) {
                      return TransactionItem(
                        sId: item.sId,
                        title: toTitleCase(item.categoryName),
                        datetime: item.date,
                        transactionCode: item.transactionCode,
                        nominal: item.totalAmount,
                        isIncome: item.typeName,
                        notes: item.note,
                        paddingHorizontal: 10,
                      );
                    }).toList(),
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
          ),
        ],
      ),
    );
  }

  // ---------------- CATEGORY GRID ----------------
  Widget _categoriesItemSection() {
    return SliverPadding(
      padding: EdgeInsets.only(
          left: defaultMargin, right: defaultMargin, bottom: 60),
      sliver: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return _buildLoadingGrid();
          } else if (state is TransactionSuccess) {
            final categories = selectedMenu == "All"
                ? (state.categoryTransaction as CategoriesModelProps).data
                : (state.categoryTransaction as CategoriesModelProps)
                    .data
                    .where(
                        (item) => item.typeName == selectedMenu.toLowerCase())
                    .toList();
            return _buildCategoryGrid(categories);
          }
          return _buildErrorGrid();
        },
      ),
    );
  }

  SliverGrid _buildLoadingGrid() => SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => const CategoryBoxLoading(),
          childCount: 4,
        ),
      );

  SliverGrid _buildErrorGrid() => SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => const CategoryErrorItem(),
          childCount: 4,
        ),
      );

  SliverGrid _buildCategoryGrid(List<CategoryDaum> categories) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final data = categories[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              createRoute(DetailCategoryPage(
                title: data.category,
                typeName: data.typeName,
              )),
            ),
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kBaseColors,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: .5,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/${data.category.replaceAll(" ", "").toLowerCase()}_pulsar.png",
                    height: 60,
                    width: 60,
                  ),
                  const Spacer(),
                  Text(
                    toTitleCase(data.category),
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semibold),
                  ),
                  Text(
                    formatCurrency(data.totalAmount),
                    style: greyTextStyle.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
        childCount: categories.length,
      ),
    );
  }
}

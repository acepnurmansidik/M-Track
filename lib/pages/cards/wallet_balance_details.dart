import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/transaction_item.dart';

class WalletBalanceDetails extends StatefulWidget {
  const WalletBalanceDetails({super.key});

  @override
  State<WalletBalanceDetails> createState() => _WalletBalanceDetailsState();
}

class _WalletBalanceDetailsState extends State<WalletBalanceDetails> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              _balanceInfoSection(),
            ],
          ),
          _detailMonthlyTransaction(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      surfaceTintColor: kPrimaryV2Color,
      backgroundColor: kPrimaryV2Color,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_left, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceInfoSection() {
    Widget itemNavigation({EdgeInsets margin = EdgeInsets.zero}) {
      return Container(
        height: 55,
        width: 55,
        margin: margin,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(14),
        ),
      );
    }

    return Container(
      alignment: Alignment.topCenter,
      height: 400,
      decoration: BoxDecoration(
        color: kPrimaryV2Color,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 275,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  kWhiteColor.withOpacity(.2),
                  BlendMode.srcIn,
                ),
                image: const AssetImage('assets/wave1.png'),
              ),
            ),
          ),
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
              } else if (state is WalletSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      formatCurrency(state.walletSelected.amount),
                      style: whiteTextStyle.copyWith(
                        fontSize: 32,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.walletSelected.vaNumber,
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: light,
                      ),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    formatCurrency(634762342),
                    style: whiteTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatCurrency(634762342),
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: light,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                itemNavigation(margin: const EdgeInsets.only(left: 0)),
                itemNavigation(margin: const EdgeInsets.only(left: 20)),
                itemNavigation(margin: const EdgeInsets.only(left: 20)),
                itemNavigation(margin: const EdgeInsets.only(left: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailMonthlyTransaction() {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.65,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return Container(
                  padding: EdgeInsets.only(top: defaultMargin),
                  decoration: BoxDecoration(color: kWhiteColor),
                  child: Center(
                    child: CircularProgressIndicator(color: kPrimaryV2Color),
                  ),
                );
              } else if (state is TransactionSuccess) {
                final reversedData =
                    state.transactionPeriode.data.reversed.toList();
                return Container(
                  padding: EdgeInsets.only(top: defaultMargin),
                  decoration: BoxDecoration(color: kWhiteColor),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Daftar transaksi menggunakan ListView dengan scrollController
                      Container(
                        margin: const EdgeInsets.only(
                          top: 75,
                          left: 15,
                          right: 15,
                        ),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: state.transactionPeriode
                              .data[selectedIndex].listData.length,
                          itemBuilder: (context, index) {
                            final everyItem = state.transactionPeriode
                                .data[selectedIndex].listData[index];
                            return TransactionItem(
                              sId: everyItem.sId,
                              nominal: everyItem.totalAmount,
                              datetime: everyItem.date,
                              title: everyItem.categoryName,
                              isIncome: everyItem.typeName,
                              color: Colors.grey[100]!,
                            );
                          },
                        ),
                      ),
                      // Header dan drag handle
                      Column(
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: kDoveGreyColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    reversedData.asMap().entries.map((entry) {
                                  final idx = entry.key;
                                  final periode = entry.value.periode;
                                  // Karena data dibalik, indeks asli = originalLength - 1 - idx
                                  final originalIndex =
                                      state.transactionPeriode.data.length -
                                          1 -
                                          idx;
                                  final isSelected =
                                      selectedIndex == originalIndex;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = originalIndex;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultMargin,
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: isSelected
                                                ? kPrimaryV2Color
                                                : kWhiteColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        periode,
                                        style: blackTextStyle.copyWith(
                                          fontWeight:
                                              isSelected ? semibold : light,
                                          color: isSelected
                                              ? kPrimaryV2Color
                                              : kGreyColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              // Default fallback UI jika state lain
              return Container(
                padding: EdgeInsets.only(top: defaultMargin),
                decoration: BoxDecoration(color: kWhiteColor),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // TODO: Tambahkan daftar transaksi default jika ada
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 5,
                          width: 50,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: kDoveGreyColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultMargin, vertical: 15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: kPrimaryV2Color, width: 2),
                                    ),
                                  ),
                                  child: Text(
                                    'July 2025',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: semibold,
                                        color: kPrimaryV2Color),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

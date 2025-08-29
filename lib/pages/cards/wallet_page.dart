import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracking/pages/cards/wallet_balance_details.dart';
import 'package:tracking/pages/cards/wallet_item.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/custom_widget.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/notification_item.dart';
import 'package:tracking/widgets/transaction_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeDataChart {
  TypeDataChart(
    this.periode,
    this.totalExpense,
    this.totalIncome,
  );

  final String periode;
  final int totalIncome;
  final int totalExpense;
}

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // Swipe ke kanan
      setState(() {});
    } else if (details.delta.dx < 0) {
      // Swipe ke kiri
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        top: 50,
        bottom: 30,
      ),
      children: [
        _titleSection(),
        _cardSection(),
        _listButtonSection(),
        _typeChartSection(),
        _typeSection(),
        _categoryListSection(),
      ],
    );
  }

  Widget _titleSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Hi, "),
                      TextSpan(text: toTitleCase("john doe")),
                    ],
                    style: blackTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  'How are you today',
                  style: greyTextStyle.copyWith(
                      color: kGreyColor.withOpacity(.9), fontSize: 12),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: kGreenColor.withOpacity(.05),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: kGreenColor.withOpacity(.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.card_giftcard_rounded,
                  size: 20,
                  color: kGreenColor,
                ),
                const SizedBox(width: 5),
                Text(
                  "Reward",
                  style: greenTextStyle,
                )
              ],
            ),
          ),
          NotificationItem(isShowNotif: false),
        ],
      ),
    );
  }

  Widget _cardSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      child: Stack(
        children: [
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
              } else if (state is WalletSuccess) {
                return WalletItem(
                  nominal: state.walletSelected.amount,
                  vaNumber: state.walletSelected.vaNumber,
                  number: state.walletSelected.number,
                  exp: state.walletSelected.exp,
                  currency:
                      state.walletSelected.currencyId.value!.toUpperCase(),
                );
              }
              return WalletItem();
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 45,
                width: 130,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kBlackColor,
                ),
                child: Text(
                  "Add Money",
                  style: whiteTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listButtonSection() {
    Widget itemButton(String title, Function onNavigation) {
      return GestureDetector(
        onTap: () => onNavigation(),
        child: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kGreyColor.withOpacity(.15),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$title.png'),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          itemButton("card", () {
            Navigator.push(context, createRoute(const WalletBalanceDetails()));
          }),
          itemButton("send", () {}),
          itemButton("menu", () {}),
          itemButton("menu", () {}),
          itemButton("menu", () {}),
        ],
      ),
    );
  }

  Widget _typeSection() {
    Widget buildCashflowItem(bool isIncome, String title, int amount) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2.23,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isIncome ? Colors.green[50] : Colors.red[50],
              ),
              child: Transform.rotate(
                angle: isIncome ? 1.6 : -1.6,
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: isIncome ? Colors.green[500] : Colors.red[500],
                ),
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
                Text(title, style: greyTextStyle),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 60,
      child: Row(
        children: [
          buildCashflowItem(true, "Income", 5000000),
          Container(
            height: 50,
            width: .3,
            color: kGreyColor,
          ),
          buildCashflowItem(false, "Expense", 2000000),
        ],
      ),
    );
  }

  Widget _typeChartSection() {
    List<TypeDataChart> dChart = [
      TypeDataChart('Jan 2025', 35, 40),
      TypeDataChart('Feb 2025', 60, 36),
      TypeDataChart('Mar 2025', 98, 34),
      TypeDataChart('Apr 2025', 34, 75),
      TypeDataChart('Mei 2025', 56, 42),
      TypeDataChart('Jun 2025', 77, 65),
      TypeDataChart('Jul 2025', 24, 67),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 230,
        margin: const EdgeInsets.only(bottom: 20, top: 10),
        width: (dChart.length * 60) + 50,
        child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          margin: const EdgeInsets.all(0),
          enableMultiSelection: true,
          plotAreaBorderWidth: 0,
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 1),
            axisLine: AxisLine(width: 1),
            majorTickLines: MajorTickLines(size: 1),
          ),
          primaryYAxis: const NumericAxis(
            // isVisible: false,
            majorGridLines: MajorGridLines(width: 1),
            axisLine: AxisLine(width: 1),
            majorTickLines: MajorTickLines(size: 1),
          ),
          series: [
            LineSeries<TypeDataChart, String>(
              name: "Income",
              color: kGreenColor,
              markerSettings: const MarkerSettings(isVisible: true),
              onRendererCreated: (controller) {},
              onPointLongPress: (pointInteractionDetails) {},
              dataSource: dChart,
              xValueMapper: (TypeDataChart sales, _) => sales.periode,
              yValueMapper: (TypeDataChart sales, _) => sales.totalIncome,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
            LineSeries<TypeDataChart, String>(
              name: "Expense",
              color: kRedColor,
              markerSettings: const MarkerSettings(isVisible: true),
              onRendererCreated: (controller) {},
              onPointLongPress: (pointInteractionDetails) {},
              dataSource: dChart,
              xValueMapper: (TypeDataChart sales, _) => sales.periode,
              yValueMapper: (TypeDataChart sales, _) => sales.totalExpense,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "Last transaction",
            style: blackTextStyle.copyWith(fontSize: 15, fontWeight: semibold),
          ),
        ),
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                } else if (state is TransactionSuccess) {
                  return Column(
                    children: state.listItemTransaction.data.map((everyItem) {
                      return TransactionItem(
                        sId: everyItem.sId,
                        nominal: everyItem.totalAmount,
                        datetime: everyItem.date,
                        title: everyItem.categoryName,
                        isIncome: everyItem.typeName,
                      );
                    }).toList(),
                  );
                }
                return const Column(
                  children: [
                    TransactionItem(
                      sId: "1",
                      nominal: 500,
                      datetime: "Aug 24, 2025, 8:10 AM",
                      title: "Freelance",
                      isIncome: "income",
                    ),
                    TransactionItem(
                      sId: "2",
                      nominal: 500,
                      datetime: "Aug 24, 2025, 9:10 AM",
                      title: "Freelance",
                      isIncome: "expense",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/transaction_item.dart';

class CategoryDataChart {
  CategoryDataChart(
    this.periode,
    this.totalExpense,
    this.totalIncome,
    this.totalLoan,
  );
  final String periode;
  final int totalIncome;
  final int totalExpense;
  final int totalLoan;
}

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
        _cardSection(),
        _listButtonSection(),
        _typeChartSection(),
        _typeSection(),
        _chartCategorySection(),
        _categoryListSection(),
      ],
    );
  }

  Widget _cardSection() {
    Widget itemCard(String title, String subtitle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 12,
              color: kWhiteColor.withOpacity(.8),
            ),
          ),
          Text(
            subtitle,
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              color: kWhiteColor,
              fontWeight: semibold,
            ),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      child: Stack(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: kPrimaryV2Color,
              image: DecorationImage(
                image: const AssetImage('assets/img_background.png'),
                colorFilter: ColorFilter.mode(
                  kWhiteColor.withOpacity(.15),
                  BlendMode.srcIn,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatCurrency(9127312300),
                          style: whiteTextStyle.copyWith(
                            fontSize: 28,
                            fontWeight: semibold,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "+2.5%",
                            children: [
                              TextSpan(
                                text: " from last month",
                                style: whiteTextStyle.copyWith(
                                  fontWeight: light,
                                ),
                              ),
                            ],
                            style:
                                whiteTextStyle.copyWith(fontWeight: semibold),
                          ),
                        ),

                        // )
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            kWhiteColor,
                            BlendMode.srcIn,
                          ),
                          image: const AssetImage(
                            'assets/contactless-payment.png',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Text(
                    "4564 7236 0927 2153 8236",
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: light,
                    ),
                  ),
                ),
                Row(
                  children: [
                    itemCard("Number", "**** 2374"),
                    const SizedBox(width: 12),
                    itemCard("Exp", "12/30"),
                    const SizedBox(width: 12),
                    itemCard("Currency", "IDR"),
                  ],
                )
              ],
            ),
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
    Widget itemButton(String title) {
      return Container(
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
      );
    }

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          itemButton("card"),
          itemButton("send"),
          itemButton("menu"),
          itemButton("menu"),
          itemButton("menu"),
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
        height: 220,
        margin: const EdgeInsets.only(bottom: 20),
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
              color: kRedColor,
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
              color: kGreenColor,
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

  Widget _chartCategorySection() {
    List<CategoryDataChart> getCategoryDataChart = [
      CategoryDataChart('Jan 2025', 35, 40, 76),
      CategoryDataChart('Feb 2025', 60, 36, 43),
      CategoryDataChart('Mar 2025', 98, 34, 56),
      CategoryDataChart('Apr 2025', 34, 75, 65),
      CategoryDataChart('Mei 2025', 56, 42, 62),
      CategoryDataChart('Jun 2025', 77, 65, 56),
      CategoryDataChart('Jul 2025', 24, 67, 23),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 280,
        width: (getCategoryDataChart.length * 65) + 100,
        child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          margin: const EdgeInsets.all(0),
          enableMultiSelection: true,
          plotAreaBorderWidth: 0,
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
          ),
          primaryYAxis: const NumericAxis(
            isVisible: false,
            interval: 10,
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
          ),
          series: <CartesianSeries>[
            ColumnSeries<CategoryDataChart, String>(
              name: "Income",
              width: .80,
              dataSource: getCategoryDataChart,
              xValueMapper: (CategoryDataChart chart, _) => chart.periode,
              yValueMapper: (CategoryDataChart chart, _) => chart.totalIncome,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              onPointTap: (pointInteractionDetails) {
                setState(() {});
              },
            ),
            ColumnSeries<CategoryDataChart, String>(
              name: "Expense",
              width: .80,
              dataSource: getCategoryDataChart,
              xValueMapper: (CategoryDataChart chart, _) => chart.periode,
              yValueMapper: (CategoryDataChart chart, _) => chart.totalExpense,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              onPointTap: (pointInteractionDetails) {
                setState(() {});
              },
            ),
            ColumnSeries<CategoryDataChart, String>(
              name: "Loan",
              width: .80,
              dataSource: getCategoryDataChart,
              xValueMapper: (CategoryDataChart chart, _) => chart.periode,
              yValueMapper: (CategoryDataChart chart, _) => chart.totalLoan,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              onPointTap: (pointInteractionDetails) {
                setState(() {});
              },
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
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(
            "Last transaction",
            style: blackTextStyle.copyWith(fontSize: 15, fontWeight: semibold),
          ),
        ),
        const Column(
          children: [
            TransactionItem(
              nominal: 500,
              datetime: "Aug 24, 2025, 8:10 AM",
              title: "Freelance",
              isIncome: "income",
            ),
            TransactionItem(
              nominal: 500,
              datetime: "Aug 24, 2025, 9:10 AM",
              title: "Freelance",
              isIncome: "expense",
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/skelaton/category_list_loading.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/category_error_item.dart';
import 'package:tracking/widgets/category_item.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

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

class _ActivityPageState extends State<ActivityPage> {
  int selectedIndexFilter = 3;
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
        _selectedFilterSection(),
        _chartCategorySection(),
        _categoryListSection(),
      ],
    );
  }

  Widget _selectedFilterSection() {
    Widget filterItem(String title, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndexFilter = index;
          });
        },
        child: Container(
          width: 65,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: index == selectedIndexFilter
                ? kPrimaryV2Color
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: bold,
              color: index == selectedIndexFilter
                  ? kWhiteColor
                  : kBlackColor.withOpacity(.8),
              letterSpacing: 2,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 45, right: 45, bottom: 30),
      decoration: BoxDecoration(
        color: kGreyColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          filterItem("1M", 0),
          filterItem("3M", 1),
          filterItem("6M", 2),
          filterItem("1Y", 3),
        ],
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 15),
          BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Column(
                  children: [
                    CategoryListLoading(),
                    CategoryListLoading(),
                    CategoryListLoading(),
                  ],
                );
              } else if (state is TransactionSuccess) {
                return Column(
                  children: state.categoryTransaction.data.map((everyCatItem) {
                    return CategoryItem(
                      nominal: everyCatItem.totalAmount,
                      title: everyCatItem.category,
                    );
                  }).toList(),
                );
              }
              return const Column(
                children: [
                  CategoryErrorItem(),
                  CategoryErrorItem(),
                  CategoryErrorItem(),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

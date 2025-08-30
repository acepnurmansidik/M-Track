// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/statistic/cubit/chart_categories_cubit.dart';
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
    this.totalEntertaiment,
    this.totalFoodDrink,
    this.totalFreelance,
    this.totalSalaryMonthly,
  );
  final String periode;
  final int totalEntertaiment;
  final int totalFoodDrink;
  final int totalFreelance;
  final int totalSalaryMonthly;
}

class _ActivityPageState extends State<ActivityPage> {
  int selectedIndexFilter = 3;

  List<CategoryDataChart> newGetCategoryDataChart = [
    CategoryDataChart('Jan 2025', 0, 0, 0, 0),
    CategoryDataChart('Feb 2025', 0, 0, 0, 0),
    CategoryDataChart('Mar 2025', 0, 0, 0, 0),
    CategoryDataChart('Apr 2025', 0, 0, 0, 0),
    CategoryDataChart('Mei 2025', 0, 0, 0, 0),
    CategoryDataChart('Jun 2025', 0, 0, 0, 0),
    CategoryDataChart('Jul 2025', 0, 0, 0, 0),
  ];

  List<CategoryDataChart> getCategoryDataChart = [
    CategoryDataChart('Jan 2025', 35, 40, 76, 43),
    CategoryDataChart('Feb 2025', 60, 36, 43, 20),
    CategoryDataChart('Mar 2025', 98, 34, 56, 82),
    CategoryDataChart('Apr 2025', 34, 75, 65, 13),
    CategoryDataChart('Mei 2025', 56, 42, 62, 120),
    CategoryDataChart('Jun 2025', 77, 65, 56, 56),
    CategoryDataChart('Jul 2025', 24, 67, 23, 39),
  ];

  @override
  void initState() {
    context.read<ChartCategoriesCubit>().fetchInitate("1Y");
    super.initState();
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
            context.read<ChartCategoriesCubit>().fetchInitate(title);
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<ChartCategoriesCubit, ChartCategoriesState>(
        builder: (context, state) {
          if (state is ChartCategoriesLoading) {
          } else if (state is ChartCategoriesSuccess) {
            final List<CategoryDataChart> dChartCategoiresPeriode =
                state.categoryPeriode.data.map((everyItem) {
              return CategoryDataChart(
                everyItem.periode,
                everyItem.totalEntertaiment,
                everyItem.totalFoodDrink,
                everyItem.totalFreelance,
                everyItem.totalSalaryMonthly,
              );
            }).toList();

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 280,
              width: (dChartCategoiresPeriode.length * 65) + 100,
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
                  interval: 100000,
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  majorTickLines: MajorTickLines(size: 0),
                ),
                series: <CartesianSeries>[
                  ColumnSeries<CategoryDataChart, String>(
                    name: "Entertaiment",
                    width: .80,
                    dataSource: dChartCategoiresPeriode,
                    xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                    yValueMapper: (CategoryDataChart chart, _) =>
                        chart.totalEntertaiment,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    onPointTap: (pointInteractionDetails) {
                      setState(() {});
                    },
                  ),
                  ColumnSeries<CategoryDataChart, String>(
                    name: "Food & Drink",
                    width: .80,
                    dataSource: dChartCategoiresPeriode,
                    xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                    yValueMapper: (CategoryDataChart chart, _) =>
                        chart.totalFoodDrink,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    onPointTap: (pointInteractionDetails) {
                      setState(() {});
                    },
                  ),
                  ColumnSeries<CategoryDataChart, String>(
                    name: "Freelance",
                    width: .80,
                    dataSource: dChartCategoiresPeriode,
                    xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                    yValueMapper: (CategoryDataChart chart, _) =>
                        chart.totalFreelance,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    onPointTap: (pointInteractionDetails) {
                      setState(() {});
                    },
                  ),
                  ColumnSeries<CategoryDataChart, String>(
                    name: "Salary Monthly",
                    width: .80,
                    dataSource: dChartCategoiresPeriode,
                    xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                    yValueMapper: (CategoryDataChart chart, _) =>
                        chart.totalSalaryMonthly,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    onPointTap: (pointInteractionDetails) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }

          return Container(
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
                  name: "Entertaiment",
                  width: .80,
                  dataSource: getCategoryDataChart,
                  xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                  yValueMapper: (CategoryDataChart chart, _) =>
                      chart.totalEntertaiment,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  onPointTap: (pointInteractionDetails) {
                    setState(() {});
                  },
                ),
                ColumnSeries<CategoryDataChart, String>(
                  name: "Food & Drink",
                  width: .80,
                  dataSource: getCategoryDataChart,
                  xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                  yValueMapper: (CategoryDataChart chart, _) =>
                      chart.totalFoodDrink,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  onPointTap: (pointInteractionDetails) {
                    setState(() {});
                  },
                ),
                ColumnSeries<CategoryDataChart, String>(
                  name: "Freelance",
                  width: .80,
                  dataSource: getCategoryDataChart,
                  xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                  yValueMapper: (CategoryDataChart chart, _) =>
                      chart.totalFreelance,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  onPointTap: (pointInteractionDetails) {
                    setState(() {});
                  },
                ),
                ColumnSeries<CategoryDataChart, String>(
                  name: "Salary Monthly",
                  width: .80,
                  dataSource: getCategoryDataChart,
                  xValueMapper: (CategoryDataChart chart, _) => chart.periode,
                  yValueMapper: (CategoryDataChart chart, _) =>
                      chart.totalSalaryMonthly,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  onPointTap: (pointInteractionDetails) {
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
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

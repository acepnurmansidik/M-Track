// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/transaction_item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.periode, this.nominal);
  final String periode;
  final int nominal;
}

class DetailCategoryPage extends StatefulWidget {
  final String title;
  final String typeName;

  const DetailCategoryPage({
    super.key,
    required this.title,
    required this.typeName,
  });

  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  late int selectedIndex;
  late PeriodeProp dataSelected;
  late String labelSelected;

  List<ChartData> dBarChart = [];

  List<ChartData> getChartData = [
    ChartData('Aug 2025', 30),
    ChartData('Jul 2025', 38),
    ChartData('Jun 2025', 35),
    ChartData('May 2025', 40),
    ChartData('Apr 2025', 32),
    ChartData('Mar 2025', 34),
    ChartData('Feb 2025', 28),
    ChartData('Jan 2025', 35),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 11 - (DateTime.now().month - 1);
  }

  @override
  Widget build(BuildContext context) {
    labelSelected = getChartData[selectedIndex].periode;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: kBaseColors,
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
          } else if (state is TransactionSuccess) {
            dataSelected = state.transactionPeriode.data[0];
            labelSelected = state.transactionPeriode.data[0].periode;
            dBarChart =
                state.transactionPeriode.data[0].listData.map((everyItem) {
              return ChartData(everyItem.date, everyItem.totalAmount);
            }).toList();
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              children: [
                _buildTitleSection(),
                _buildBarChartSection(),
                _buildCashflowSection(),
                _buildTransactionListSection(),
              ],
            );
          }
          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildTransactionListSection() {
    List<Widget> _buildEmptyTransactionMessage() {
      return [
        SizedBox(
          height: 150,
          child: Column(
            children: [
              Container(
                height: 115,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/empty-box.png'),
                  ),
                ),
              ),
              Text(
                "Aww... there's no transaction",
                style: blackTextStyle.copyWith(fontWeight: medium),
              ),
            ],
          ),
        ),
      ];
    }

    return SizedBox(
      height: dataSelected.listData.isNotEmpty ? 250 : 150,
      child: SingleChildScrollView(
        child: Column(
          children: dataSelected.listData.isNotEmpty
              ? dataSelected.listData.map((everyItem) {
                  return TransactionItem(
                    title: everyItem.categoryName,
                    datetime: everyItem.date,
                    nominal: everyItem.totalAmount,
                    isIncome: everyItem.typeName,
                  );
                }).toList()
              : _buildEmptyTransactionMessage(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: kBaseColors,
      title: Row(
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
            child: Text(
              toTitleCase(widget.title),
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "Spending · "),
              TextSpan(text: labelSelected),
            ]),
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            formatRupiah(dataSelected.totalCategory),
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
          ),
        ],
      ),
    );
  }

  Widget _buildCashflowSection() {
    Widget _buildCashflowItem(bool isIncome, String title, int amount) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2.23,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCashflowItem(true, "Income", dataSelected.income),
          _buildCashflowItem(false, "Spending", dataSelected.expense),
        ],
      ),
    );
  }

  Widget _buildBarChartSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 280,
        width: (dBarChart.length * 65) + 100,
        child: SfCartesianChart(
          margin: const EdgeInsets.all(0),
          plotAreaBorderWidth: 0,
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
          ),
          primaryYAxis: const NumericAxis(
            isVisible: false,
            interval: 5,
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
          ),
          series: <CartesianSeries>[
            ColumnSeries<ChartData, String>(
              width: .65,
              dataSource: getChartData,
              xValueMapper: (ChartData chart, _) => chart.periode,
              yValueMapper: (ChartData chart, _) => chart.nominal,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey[200],
              onPointTap: (pointInteractionDetails) {
                setState(() {
                  selectedIndex = pointInteractionDetails.pointIndex!;
                });
              },
              pointColorMapper: (ChartData data, int index) {
                return index == selectedIndex
                    ? kPrimaryV2Color
                    : Colors.grey[200];
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      padding: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        bottom: 20,
      ),
      children: [
        _buildTitleSection(),
        _buildBarChartSection(),
        _buildCashflowSection(),
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
        _buildTransactionListSection(),
      ],
    );
  }
}

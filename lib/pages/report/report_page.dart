import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/transaction_item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.month, this.value);
  final String month;
  final double value;
}

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? selectedValue = 'Income';
  int? selectedIndex;

  List<SalesData> getChartData() {
    return [
      SalesData('Dec 2025', 40),
      SalesData('Nov 2025', 36),
      SalesData('Oct 2025', 38),
      SalesData('Sep 2025', 42),
      SalesData('Aug 2025', 30),
      SalesData('Jul 2025', 38),
      SalesData('Jun 2025', 35),
      SalesData('May 2025', 40),
      SalesData('Apr 2025', 32),
      SalesData('Mar 2025', 34),
      SalesData('Feb 2025', 28),
      SalesData('Jan 2025', 35),
    ];
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = 11 - (DateTime.now().month - 1);
  }

  @override
  Widget build(BuildContext context) {
    final chartData = getChartData();
    final label = chartData[selectedIndex!].month;

    Widget appBarSection() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kBaseColors,
        surfaceTintColor: kBaseColors,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
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
                // <-- Biarkan teks mengambil sisa ruang
                child: Text(
                  "Report",
                  textAlign: TextAlign.center, // <-- Pusatkan teks
                  style: blackTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
      );
    }

    Widget titleSection({String title = "", int nominal = 0}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: "Spending · "),
                TextSpan(text: title != "" ? title : label),
              ]),
              style: greyTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatRupiah(nominal),
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semibold,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget barChartSection() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 280,
          width:
              (getChartData().length * 65) + 100, // 50px per batang + padding
          child: SfCartesianChart(
            margin: const EdgeInsets.all(0),
            plotAreaBorderWidth: 0,
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(width: 0), // Hilangkan garis axis horizontal
              majorTickLines: MajorTickLines(size: 0), // Hilangkan tick marks
            ),
            primaryYAxis: const NumericAxis(
              isVisible: false,
              interval: 5,
              majorGridLines:
                  MajorGridLines(width: 0), // Hilangkan grid horizontal
              axisLine: AxisLine(width: 0), // Hilangkan garis axis
              majorTickLines: MajorTickLines(size: 0),
            ),
            series: <CartesianSeries>[
              ColumnSeries<SalesData, String>(
                width: .65,
                // spacing: .1,
                dataSource: getChartData(),
                xValueMapper: (SalesData sales, _) => sales.month,
                yValueMapper: (SalesData sales, _) => sales.value,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                  textStyle: TextStyle(color: Colors.black),
                ),
                borderRadius: BorderRadius.circular(7),

                color: Colors.grey[200], // Warna default abu-abu
                onPointTap: (pointInteractionDetails) {
                  setState(() {
                    selectedIndex = pointInteractionDetails.pointIndex;
                  });
                },
                pointColorMapper: (SalesData data, int index) {
                  return index == selectedIndex
                      ? kPrimaryV2Color
                      : Colors.grey[200]; // Warna abu-abu default
                },
              )
            ],
          ),
        ),
      );
    }

    Widget cashflowSection() {
      Widget cashflowItem(bool isIncome, String title, int amount) {
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
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: isIncome ? Colors.green[500] : Colors.red[500],
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
                  Text(
                    title,
                    style: greyTextStyle,
                  ),
                ],
              )
            ],
          ),
        );
      }

      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cashflowItem(true, "Income", 100000),
            cashflowItem(false, "Spending", 20000),
          ],
        ),
      );
    }

    Widget transactionListSection() {
      return const Column(
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
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      backgroundColor: kBaseColors,
      body: ListView(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: 20,
        ),
        children: [
          titleSection(),
          barChartSection(),
          cashflowSection(),
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
          transactionListSection(),
        ],
      ),
    );
  }
}

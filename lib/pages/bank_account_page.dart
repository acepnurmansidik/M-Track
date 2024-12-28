import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracking/cubit/wallet_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/shimmer_loading.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  ChartSeriesController? chartSeriesController;
  int? pointIndex;

  @override
  void initState() {
    context.read<WalletCubit>().fetchWalletList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Acep Nurman Sidik",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Welcome back",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 28,
              width: 28,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/stopwatch.png'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget virtualCard() {
      Widget addWallet() {
        return Container(
          height: 190,
          width: MediaQuery.of(context).size.width - 55,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.only(right: 5),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/plus.png'),
                  ),
                ),
              ),
              Text(
                'Add New Card',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semibold,
                ),
              )
            ],
          ),
        );
      }

      Widget loadingWallet() {
        return Container(
          height: 190,
          width: MediaQuery.of(context).size.width - 55,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: const EdgeInsets.only(bottom: 20, right: 20),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: kLineDarkColor,
                highlightColor: kWhiteColor,
                child: Container(
                  height: 30,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kLineDarkColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: kLineDarkColor,
                    highlightColor: kWhiteColor,
                    child: Container(
                      height: 35,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kLineDarkColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            height: 12,
                            width: 110,
                            radius: 6,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerLoading(
                                height: 18,
                                width: 180,
                                radius: 6,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        width: 60,
                        child: ShimmerLoading(
                          height: 30,
                          width: 50,
                          radius: 8,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return loadingWallet();
            } else if (state is WalletFetchSuccess) {
              final List<Widget> result;
              if (state.listWallet.isNotEmpty) {
                result = state.listWallet.map((item) {
                  return Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width - 55,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              width: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/visa.png',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              height: 30,
                              width: 70,
                              child: Text(
                                item.walletName,
                                style:
                                    blackTextStyle.copyWith(fontWeight: bold),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              NumberFormat.currency(
                                      symbol: "IDR ", decimalDigits: 0)
                                  .format(item.amount),
                              style: TextStyle(fontSize: 32, fontWeight: bold),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Virtual Number ID',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: medium,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item.vaNumber,
                                      style: blackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: semibold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 60,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Opacity(
                                        opacity: .7,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kGreenColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList();

                result.add(addWallet());
              } else {
                result = [addWallet()];
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: result,
              );
            }

            return Row(
              children: [
                Container(
                  height: 190,
                  width: MediaQuery.of(context).size.width - 55,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/plus.png'),
                          ),
                        ),
                      ),
                      Text(
                        'Please reload page',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semibold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    Widget recentActiviy() {
      final List<CategoryActivityData> chartData = [
        CategoryActivityData('Category A', 30),
        CategoryActivityData('Category B', 25),
        CategoryActivityData('Category C', 20),
        CategoryActivityData('Category D', 15),
        CategoryActivityData('Category E', 60),
      ];
      Widget activityItem({title, nominal, type, date}) {
        return Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kWhiteColor,
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cash_out.png'),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                  NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                      .format(nominal),
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ))
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Recent Activity",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: kWhiteColor,
              ),
              child: SfCircularChart(
                legend: const Legend(
                  isVisible: true,
                  position: LegendPosition.left,
                  shouldAlwaysShowScrollbar: true,
                  toggleSeriesVisibility: false,
                ),
                enableMultiSelection: true,
                series: <CircularSeries>[
                  PieSeries<CategoryActivityData, String>(
                    explode: true,
                    dataSource: chartData,
                    xValueMapper: (CategoryActivityData data, _) =>
                        data.category,
                    yValueMapper: (CategoryActivityData data, _) => data.other,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                activityItem(
                  title: "Top Up Gopay",
                  date: "20",
                  nominal: 50000,
                  type: "cash-out",
                ),
                activityItem(
                  title: "Top Up Gopay",
                  date: "20",
                  nominal: 50000,
                  type: "cash-out",
                ),
                activityItem(
                  title: "Top Up Gopay",
                  date: "20",
                  nominal: 50000,
                  type: "cash-out",
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget totalSummary() {
      Widget totalSummaryItem({
        String title = "",
        int nominal = 0,
        String percent = "",
      }) {
        return Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: (MediaQuery.of(context).size.width / 2) - 47,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                NumberFormat.currency(
                  symbol: "",
                  decimalDigits: 0,
                ).format(nominal),
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semibold,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 60,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: kGreenColor.withOpacity(.2),
                ),
                child: Text(
                  "+$percent %",
                  style: greenTextStyle.copyWith(fontSize: 14),
                ),
              )
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Total In & Out",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      totalSummaryItem(
                        title: "In",
                        nominal: 150000000,
                        percent: "50",
                      ),
                      Container(
                        height: 70,
                        width: 1,
                        decoration: BoxDecoration(color: kGreyColor),
                      ),
                      totalSummaryItem(
                        title: "Out",
                        nominal: 500000,
                        percent: "50",
                      ),
                    ],
                  ),
                  Container(
                    height: 220,
                    margin: const EdgeInsets.only(top: 10),
                    child: SfCartesianChart(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      onChartTouchInteractionMove: (args) {
                        if (pointIndex != null) {
                          CartesianChartPoint dragPoint = chartSeriesController!
                              .pixelToPoint(args.position);

                          chartSeriesController!.updateDataSource(
                              updatedDataIndex:
                                  pointIndex!); // Refresh the chart
                        }
                      },
                      onChartTouchInteractionUp:
                          (ChartTouchInteractionArgs args) {
                        pointIndex = null; // Reset point index after drag
                      },
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                        enablePanning: true,
                        zoomMode: ZoomMode.xy,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: const CategoryAxis(),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          name: "Income",
                          color: kGreenColor,
                          onRendererCreated: (controller) {
                            chartSeriesController = controller;
                          },
                          onPointLongPress: (pointInteractionDetails) {
                            pointIndex = pointInteractionDetails.pointIndex;
                          },
                          dataSource: <SalesData>[
                            SalesData('Jan', 30, 100),
                            SalesData('Feb', 40, 25),
                            SalesData('Mar', 10, 70),
                            SalesData('Apr', 80, 40),
                            SalesData('May', 70, 25),
                            SalesData('Jun', 85, 15),
                            SalesData('Jul', 65, 4),
                            SalesData('Aug', 18, 59),
                            SalesData('Sep', 40, 12),
                            SalesData('Oct', 60, 49),
                            SalesData('Nov', 26, 80),
                            SalesData('Dec', 46, 17),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.income,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                        LineSeries<SalesData, String>(
                          name: "Outcome",
                          color: kRedColor,
                          markerSettings: MarkerSettings(isVisible: true),
                          onRendererCreated: (controller) {
                            chartSeriesController = controller;
                          },
                          onPointLongPress: (pointInteractionDetails) {
                            pointIndex = pointInteractionDetails.pointIndex;
                          },
                          dataSource: <SalesData>[
                            SalesData('Jan', 30, 100),
                            SalesData('Feb', 40, 25),
                            SalesData('Mar', 10, 70),
                            SalesData('Apr', 80, 40),
                            SalesData('May', 70, 25),
                            SalesData('Jun', 85, 15),
                            SalesData('Jul', 65, 4),
                            SalesData('Aug', 18, 59),
                            SalesData('Sep', 40, 12),
                            SalesData('Oct', 60, 49),
                            SalesData('Nov', 26, 80),
                            SalesData('Dec', 46, 17),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.outcome,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return ListView(
      children: [
        appBar(),
        virtualCard(),
        totalSummary(),
        recentActiviy(),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.income, this.outcome);
  final String year;
  final double income;
  final double outcome;
}

class CategoryActivityData {
  CategoryActivityData(this.category, this.other);
  final String category;
  final double other;
}

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tracking/cubit/loan_cubit.dart';
import 'package:tracking/theme.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  void initState() {
    super.initState();
    context.read<LoanCubit>().getIndexLoan();
  }

  @override
  Widget build(BuildContext context) {
    Widget loanItem(
        {title, nominal, imageUrl, date, from, to, isIncome, isPaid}) {
      return Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kWhiteColor,
        ),
        child: Stack(alignment: Alignment.centerRight, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    isPaid == true ? kGreenColor : kRedColor, BlendMode.srcIn),
                image: AssetImage(
                    isPaid == true ? 'assets/warranty.png' : 'assets/x.png'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
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
                      '$from to $to',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                          .format(nominal),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                        color: isIncome == true ? kGreenColor : kRedColor,
                      ),
                    ),
                    Text(
                      '$date',
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                        // fontWeight: bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      );
    }

    return BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        if (state is LoanLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoanSuccesss) {
          return ListView(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 50),
            children: state.loanList.map((item) {
              return loanItem(
                title: item.title,
                nominal: item.nominal,
                date: item.createdAt,
                from: item.fromName,
                to: item.toName,
                imageUrl: item.imageUrl,
                isPaid: item.statusPaid,
              );
            }).toList(),
            // children: [

            // ],
          );
        }

        return ListView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 50),
          children: [
            loanItem(
              title: "TEST",
              nominal: 1000,
              date: "asdad",
              imageUrl:
                  "http://localhost:3022/uploads/images/1734896048168gqc69lmosdd3228971938High-Speed-Train-Side--Streamline-Plump-(1).png",
            )
          ],
        );
      },
    );
  }
}

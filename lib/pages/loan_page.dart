// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tracking/cubit/loan_cubit.dart';
import 'package:tracking/pages/form_loan_page.dart';
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
    Widget loanItem({data}) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormLoanPage(dataLoan: data, isEdit: true),
            ),
          );
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 40,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kWhiteColor,
          ),
          child: Stack(alignment: Alignment.centerRight, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/exchange.png'),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title,
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semibold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${data.fromName} to ${data.toName}',
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
                            .format(data.nominal),
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color:
                              data.isIncome == true ? kGreenColor : kRedColor,
                        ),
                      ),
                      Text(
                        '${data.createdAt}',
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
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
              return loanItem(data: item);
            }).toList(),
          );
        }

        return ListView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 50),
          children: [loanItem()],
        );
      },
    );
  }
}

// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/action_delete/action_delete_cubit.dart';
import 'package:tracking/pages/detail_transaction_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/custom_widget.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/slide_edit_backgroud.dart';
import 'package:tracking/widgets/slide_remove_backgroud.dart';

class TransactionItem extends StatelessWidget {
  final String sId;
  final String title;
  final String isIncome;
  final int nominal;
  final String datetime;
  final String notes;
  final double paddingHorizontal;
  final Color color;
  final bool isActiveDismissible;

  const TransactionItem({
    super.key,
    required this.sId,
    required this.nominal,
    required this.datetime,
    required this.title,
    required this.notes,
    required this.isIncome,
    this.paddingHorizontal = 0,
    this.isActiveDismissible = true,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRoute(
            DetailTransactionPage(
              title: title,
              type: isIncome,
              date: datetime,
              totalAmount: nominal,
              notes: notes,
              transactionId: sId,
            ),
          ),
        );
      },
      child: Dismissible(
        key: Key(sId),
        direction: isActiveDismissible
            ? DismissDirection.horizontal
            : DismissDirection.none,
        background: const SlideEditBackgroud(),
        secondaryBackground: const SlideRemoveBackgroud(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Dragged to the left
            // return cancelBtn(true, sId);
            context.read<ActionDeleteCubit>().activate('/transaction/$sId');
            return;
          } else {
            // Dragged to the right
            // return Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => TransactionPage(
            //       transactions: transaction,
            //       isEdit: true,
            //     ),
            //   ),
            // );
            // return cancelBtn(false);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: paddingHorizontal,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/${title.replaceAll(" ", "").toLowerCase()}.png',
                        ),
                        colorFilter: ColorFilter.mode(
                          kPrimaryV2Color, // Warna biru yang diinginkan
                          BlendMode
                              .srcATop, // Mode blending yang tepat untuk tint
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toTitleCase(title),
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      datetime,
                      style: greyTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome == "income" ? "+" : "-"}${formatRupiah(nominal)}',
                    style: blackTextStyle.copyWith(
                      fontWeight: semibold,
                      color: isIncome == "income" ? kGreenColor : kRedColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

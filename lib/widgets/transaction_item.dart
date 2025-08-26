import 'package:flutter/material.dart';
import 'package:tracking/pages/detail_transaction_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String isIncome;
  final int nominal;
  final String datetime;

  const TransactionItem({
    super.key,
    required this.nominal,
    required this.datetime,
    required this.title,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    Route createRoute(targetPage) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Mulai dari kanan
          const end = Offset.zero; // Berhenti di posisi normal
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRoute(
            DetailTransactionPage(
              title: "transportation",
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: kWhiteColor,
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
                    title,
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
    );
  }
}

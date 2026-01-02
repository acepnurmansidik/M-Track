import 'package:flutter/material.dart';
import 'package:tracking/pages/cards/customize_wallet_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/custom_widget.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/utils/wallet_style.dart';

class WalletItem extends StatelessWidget {
  final int nominal;
  final String vaNumber;
  final String percentage;
  final String number;
  final String exp;
  final String currency;
  final WalletThemeType styleCard;

  const WalletItem({
    super.key,
    this.nominal = 0,
    this.vaNumber = "XXXX XXXX XXXX XXXX XXXX",
    this.number = "XXXX XXXX",
    this.exp = "00/00",
    this.percentage = "~0",
    this.currency = "-",
    this.styleCard = WalletThemeType.emeraldGlow,
  });

  /// Menghindari error jika format nomor tidak sesuai
  String maskedNumber(String value) {
    final parts = value.split(" ");
    if (parts.length < 2) return "****";
    return "**** ${parts.last}";
  }

  Widget itemCard(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 12,
            color: WalletThemeData.get(styleCard).accentColor,
          ),
        ),
        Text(
          subtitle,
          style: whiteTextStyle.copyWith(
            fontSize: 14,
            color: WalletThemeData.get(styleCard).accentColor,
            fontWeight: semibold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRoute(const CustomizeWalletPage()),
        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: WalletThemeData.get(styleCard)
              .primaryColor, // gunakan style card dari enum/theme
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
            // -------- Header Nominal -----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatCurrency(nominal),
                      style: whiteTextStyle.copyWith(
                        fontSize: 28,
                        fontWeight: semibold,
                        color: WalletThemeData.get(styleCard).accentColor,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "$percentage%",
                        children: [
                          TextSpan(
                            text: " from last month",
                            style: whiteTextStyle.copyWith(fontWeight: light),
                          ),
                        ],
                        style: whiteTextStyle.copyWith(fontWeight: semibold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/contactless-payment.png'),
                      colorFilter: ColorFilter.mode(
                        WalletThemeData.get(styleCard)
                            .accentColor, // gunakan style card dari enum/theme
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ---------- VA Number -----------
            Expanded(
              child: Text(
                vaNumber,
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: light,
                ),
              ),
            ),

            // ---------- Bottom Info Row -----------
            Row(
              children: [
                itemCard("Number", maskedNumber(number)),
                const SizedBox(width: 12),
                itemCard("Exp", exp),
                const SizedBox(width: 12),
                itemCard("Currency", currency),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

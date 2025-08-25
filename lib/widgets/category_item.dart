import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final int nominal;

  const CategoryItem({
    super.key,
    required this.nominal,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/${title.replaceAll(" ", "").toLowerCase()}_pulsar.png',
                  ),
                ),
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
                const SizedBox(height: 1),
                Text(
                  formatCurrency(nominal),
                  style: greyTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

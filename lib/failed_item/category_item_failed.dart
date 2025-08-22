import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class CategoryItemFailed extends StatelessWidget {
  const CategoryItemFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 150,
        width: 165,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kBaseColors,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: .5,
              blurRadius: 15,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/reload.png"),
                ),
              ),
            ),
            const Spacer(),
            Text(
              toTitleCase(
                  ". . . . . ."), // Ganti dengan nama kategori dari model
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            Text(
              formatRupiah(0), // Ganti dengan jumlah dari model
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

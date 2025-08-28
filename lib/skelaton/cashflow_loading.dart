import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking/theme.dart';

class CashflowLoading extends StatelessWidget {
  const CashflowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.93 - 111,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Shimmer.fromColors(
                baseColor: kLineDarkColor,
                highlightColor: kWhiteColor,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kLineDarkColor,
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: kLineDarkColor,
                highlightColor: kWhiteColor,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kLineDarkColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Shimmer.fromColors(
            baseColor: kLineDarkColor,
            highlightColor: kWhiteColor,
            child: Container(
              height: 15,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: kLineDarkColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: kLineDarkColor,
            highlightColor: kWhiteColor,
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: kLineDarkColor,
              ),
            ),
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: kLineDarkColor,
            highlightColor: kWhiteColor,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: kLineDarkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

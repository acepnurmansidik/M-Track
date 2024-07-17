import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking/theme.dart';

class SkelatonTrxList extends StatelessWidget {
  const SkelatonTrxList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget listItems() {
      return Shimmer.fromColors(
        baseColor: kLineDarkColor,
        highlightColor: kWhiteColor,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 60,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: kLineDarkColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 150,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: kLineDarkColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Container(
                    height: 18,
                    width: 200,
                    decoration: BoxDecoration(
                        color: kLineDarkColor,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.65,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18))),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        listItems(),
                        listItems(),
                        listItems(),
                        listItems(),
                        listItems(),
                        listItems(),
                        listItems(),
                        listItems(),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 5,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: kDoveGreyColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          bottom: 15,
                          left: defaultMargin,
                          right: defaultMargin),
                      decoration: BoxDecoration(color: kWhiteColor),
                      child: Row(
                        children: [
                          Text(
                            "Transaksi",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: semibold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

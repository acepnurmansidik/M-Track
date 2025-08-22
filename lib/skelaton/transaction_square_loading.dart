import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransactionSquareLoading extends StatelessWidget {
  const TransactionSquareLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue[50],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width - 104,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 15,
                            width: 80,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[50],
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20,
                            width: 60,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[50],
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 10,
                            width: 120,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[50],
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

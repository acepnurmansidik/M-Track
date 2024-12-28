import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking/theme.dart';

class ShimmerLoading extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerLoading({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kLineDarkColor,
      highlightColor: kWhiteColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: kLineDarkColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class SlideRemoveBackgroud extends StatelessWidget {
  const SlideRemoveBackgroud({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[700],
      height: 80,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              const SizedBox(height: 3),
              Text(
                'Delete',
                style: whiteTextStyle.copyWith(
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

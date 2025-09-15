import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class SlideEditBackgroud extends StatelessWidget {
  const SlideEditBackgroud({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      height: 80,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              const SizedBox(height: 3),
              Text(
                'Edit',
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

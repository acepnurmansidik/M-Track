import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/page_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/saving-money.png"),
                ),
              ),
            ),
            Text(
              "Yeay, you did it 😍",
              style: blackTextStyle.copyWith(
                fontSize: 28,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Come on, record your money savings",
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: light),
            ),
            CustomButton(
              title: 'Back to menu',
              margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
              widthBtn: 220,
              onPressed: () {
                context.read<PageCubit>().setPage(0);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main',
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tracking/cubit/page_cubit.dart";
import "package:tracking/pages/bank_account_page.dart";
import "package:tracking/pages/loan_page.dart";
import "package:tracking/pages/home_page.dart";
import "package:tracking/pages/setting_page.dart";
import "package:tracking/theme.dart";
import "package:tracking/widgets/custom_buttom_navbar.dart";

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 53,
            width: double.infinity,
            child: switch (context.watch<PageCubit>().state) {
              0 => const HomePage(),
              1 => const BankAccountPage(),
              2 => const LoanPage(),
              3 => const SettingPage(),
              int() => throw UnimplementedError(),
            },
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomButtomNavbar(),
          ),
        ],
      ),
    );
  }
}

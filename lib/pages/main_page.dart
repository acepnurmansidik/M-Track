import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tracking/cubit/page_cubit.dart";
import "package:tracking/pages/auth/cubit/auth_cubit.dart";
import "package:tracking/pages/cards/wallet_page.dart";
import "package:tracking/pages/dashboard/home_page.dart";
import "package:tracking/pages/setting/profile_page.dart";
import "package:tracking/pages/statistic/activity_page.dart";
import "package:tracking/theme.dart";
import "package:tracking/widgets/custom_buttom_navbar.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<AuthCubit>().checkToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColors,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 53,
            width: double.infinity,
            child: switch (context.watch<PageCubit>().state) {
              0 => const HomePage(),
              1 => const WalletPage(),
              2 => const ActivityPage(),
              3 => const ProfilePage(),
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

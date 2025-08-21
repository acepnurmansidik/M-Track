import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tracking/cubit/page_cubit.dart";
import "package:tracking/pages/dashboard/home_page.dart";
import "package:tracking/pages/setting/profile_page.dart";
import "package:tracking/theme.dart";
import "package:tracking/widgets/custom_buttom_navbar.dart";

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              1 => const HomePage(),
              2 => const HomePage(),
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

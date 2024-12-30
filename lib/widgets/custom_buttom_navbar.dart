import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/page_cubit.dart';
import 'package:tracking/pages/transaction_page.dart';
import 'package:tracking/theme.dart';

class CustomButtomNavbar extends StatefulWidget {
  const CustomButtomNavbar({super.key});

  @override
  State<CustomButtomNavbar> createState() => _CustomButtomNavbarState();
}

class _CustomButtomNavbarState extends State<CustomButtomNavbar> {
  @override
  Widget build(BuildContext context) {
    Widget menuItems({iconName, onPressed, index, isMain = false}) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            context.read<PageCubit>().setPage(index);
          },
          child: Container(
            height: 53,
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              color: kWhiteColor,
              border: Border(
                top: BorderSide(width: 0.2, color: kGreyColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$iconName.png'),
                      colorFilter: context.watch<PageCubit>().state == index
                          ? ColorFilter.mode(
                              kPrimaryV2Color,
                              BlendMode.srcIn,
                            )
                          : ColorFilter.mode(
                              kGreyColor,
                              BlendMode.srcIn,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 3,
                  width: context.watch<PageCubit>().state == index ? 20 : 0,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    color: kPrimaryV2Color,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: Colors.transparent,
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            menuItems(iconName: 'home', index: 0),
            menuItems(iconName: 'card', index: 1),
            menuItems(iconName: 'plus', index: 9, isMain: true),
            menuItems(iconName: 'debt', index: 2),
            menuItems(iconName: 'profile', index: 3),
          ],
        ),
        Center(
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width / 5,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kWhiteColor,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionPage(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: kPrimaryV2Color,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: const AssetImage('assets/plus.png'),
                    colorFilter: ColorFilter.mode(
                      kWhiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

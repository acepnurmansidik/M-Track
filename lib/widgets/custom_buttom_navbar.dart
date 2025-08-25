import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/page_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class CustomButtomNavbar extends StatefulWidget {
  const CustomButtomNavbar({super.key});

  @override
  State<CustomButtomNavbar> createState() => _CustomButtomNavbarState();
}

class _CustomButtomNavbarState extends State<CustomButtomNavbar> {
  @override
  Widget build(BuildContext context) {
    Widget menuItems({iconName, onPressed, index}) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            context.read<PageCubit>().setPage(index);
          },
          child: Container(
            height: 65,
            width: MediaQuery.of(context).size.width / 5,
            color: kWhiteColor,
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
                Text(
                  toTitleCase(iconName),
                  style: blackTextStyle.copyWith(
                    fontSize: 13,
                    color: context.watch<PageCubit>().state == index
                        ? kPrimaryV2Color
                        : kGreyColor,
                  ),
                )
                // AnimatedContainer(
                //   duration: const Duration(milliseconds: 300),
                //   height: 3,
                //   width: context.watch<PageCubit>().state == index ? 20 : 0,
                //   decoration: BoxDecoration(
                //     borderRadius:
                //         const BorderRadius.vertical(top: Radius.circular(18)),
                //     color: kPrimaryV2Color,
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border(
          top: BorderSide(width: 1, color: kGreyColor.withOpacity(.25)),
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              menuItems(iconName: 'home', index: 0),
              menuItems(iconName: 'wallet', index: 1),
              menuItems(iconName: 'activity', index: 2),
              menuItems(iconName: 'profile', index: 3),
            ],
          ),
        ],
      ),
    );
  }
}

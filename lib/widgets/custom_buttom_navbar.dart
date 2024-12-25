import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/page_cubit.dart';
import 'package:tracking/theme.dart';

class CustomButtomNavbar extends StatefulWidget {
  const CustomButtomNavbar({super.key});

  @override
  State<CustomButtomNavbar> createState() => _CustomButtomNavbarState();
}

class _CustomButtomNavbarState extends State<CustomButtomNavbar> {
  @override
  Widget build(BuildContext context) {
    Widget menuItems({iconName, onPressed, index}) {
      return GestureDetector(
        onTap: () {
          context.read<PageCubit>().setPage(index);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: Colors.transparent,
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
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border(
          top: BorderSide(width: 0.2, color: kGreyColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          menuItems(
            iconName: 'home',
            index: 0,
          ),
          menuItems(
            iconName: 'wallet',
            index: 1,
          ),
          menuItems(
            iconName: 'plus',
            index: 2,
          ),
          menuItems(
            iconName: 'profile',
            index: 3,
          ),
        ],
      ),
    );
  }
}

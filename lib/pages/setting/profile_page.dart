// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      children: [
        _personalSection(),
        _settingSection(),
        _helpSection(),
        _authSection(),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20, bottom: 30),
          child: Text(
            'v2.0.0',
            style: greyTextStyle.copyWith(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget _itemNavigationMenu({
    String title = "",
    IconData icon = Icons.abc,
    Color color = Colors.black,
    bool devide = true,
    bool isLogOut = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: devide ? kGreyColor.withOpacity(.3) : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: isLogOut ? color : kPrimaryV2Color,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                toTitleCase(title),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                  color: color,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 30,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _personalSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: kGreyColor.withOpacity(.3),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toTitleCase("Personal"),
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              _itemNavigationMenu(
                title: "profile",
                icon: Icons.account_circle_outlined,
              ),
              _itemNavigationMenu(
                title: "login and security",
                icon: Icons.security_outlined,
              ),
              _itemNavigationMenu(
                title: "notification",
                icon: Icons.notifications_outlined,
                devide: false,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _settingSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: kGreyColor.withOpacity(.3),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toTitleCase("setting"),
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              _itemNavigationMenu(
                title: "profile",
                icon: Icons.account_circle_outlined,
              ),
              _itemNavigationMenu(
                title: "login and security",
                icon: Icons.security_outlined,
              ),
              _itemNavigationMenu(
                title: "notification",
                icon: Icons.notifications_outlined,
                devide: false,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _helpSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: kGreyColor.withOpacity(.3),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toTitleCase("help"),
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              _itemNavigationMenu(
                title: "care",
                icon: Icons.phone_outlined,
              ),
              _itemNavigationMenu(
                title: "support",
                icon: Icons.help_outline_outlined,
                devide: false,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _authSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(
          color: kGreyColor.withOpacity(.3),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          _itemNavigationMenu(
            title: "log out",
            icon: Icons.logout,
            color: Colors.red,
            devide: false,
            isLogOut: true,
          ),
        ],
      ),
    );
  }
}

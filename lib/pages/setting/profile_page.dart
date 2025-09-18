// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking/cubit/user/user_cubit.dart';
import 'package:tracking/pages/auth/cubit/auth_cubit.dart';
import 'package:tracking/pages/setting/security_change_pin_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/custom_widget.dart';
import 'package:tracking/utils/others.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      children: [
        _titleSection(),
        _personalSection(),
        _securitySection(),
        _helpSection(),
        _authSection(),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20, bottom: 30),
          child: Column(
            children: [
              Text(
                'Version 2.0.0',
                style: greyTextStyle.copyWith(fontSize: 12),
              ),
              Text(
                '© 2025 Powered by @acepnurmansidik_',
                style: greyTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _titleSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 40),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 15, top: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue[100],
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 25,
                    width: 200,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 15,
                    width: 100,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is UserSuccess) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[100],
                        ),
                        child: Text(
                          formatEmptyProfile(state.userProfile.data.name),
                          style: greyTextStyle.copyWith(
                            fontSize: 45,
                            fontWeight: semibold,
                            color: kPrimaryV2Color.withOpacity(.9),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kWhiteColor,
                            border: Border.all(
                              width: .2,
                              color: kGreyColor,
                            ),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: kBlackColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    toTitleCase(state.userProfile.data.name) ?? "",
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      color: kBlackColor,
                      fontWeight: bold,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: "Joined "),
                    TextSpan(text: state.userProfile.data.joinedAt),
                  ]),
                  style:
                      blackTextStyle.copyWith(fontSize: 14, color: kGreyColor),
                ),
              ],
            );
          }
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[100],
                      ),
                      child: Text(
                        formatEmptyProfile('Acep Nurman Sidik'),
                        style: greyTextStyle.copyWith(
                          fontSize: 45,
                          fontWeight: semibold,
                          color: kPrimaryV2Color.withOpacity(.9),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhiteColor,
                          border: Border.all(
                            width: .2,
                            color: kGreyColor,
                          ),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: kBlackColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Acep Nurman Sidik',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    color: kBlackColor,
                    fontWeight: bold,
                  ),
                ),
              ),
              Text.rich(
                const TextSpan(children: [
                  TextSpan(text: "Joined "),
                  TextSpan(text: "29 July 2025"),
                ]),
                style: blackTextStyle.copyWith(fontSize: 14, color: kGreyColor),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _itemNavigationMenu({
    String title = "",
    IconData icon = Icons.abc,
    bool devide = true,
    bool isActive = true,
    VoidCallback? onChange,
  }) {
    return GestureDetector(
      onTap: onChange,
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
          mainAxisAlignment: MainAxisAlignment.start, // rata kiri
          children: [
            Icon(
              icon,
              size: 25,
              color: kPrimaryV2Color,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                toTitleCase(title),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                  color: isActive ? kBlackColor : kGreyColor,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 30,
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
                title: "wallet",
                icon: Icons.wallet,
                devide: false,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _securitySection() {
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
            toTitleCase("secuity"),
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              _itemNavigationMenu(
                title: "login and security",
                icon: Icons.security_outlined,
              ),
              _itemNavigationMenu(
                title: "change password",
                icon: Icons.password,
              ),
              _itemNavigationMenu(
                title: "pin",
                icon: Icons.lock_outline_rounded,
                onChange: () {
                  Navigator.push(
                    context,
                    createRoute(const SecurityChangePinPage()),
                  );
                },
              ),
              _itemNavigationMenu(
                title: "biometrics",
                icon: Icons.fingerprint,
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
                title: "contact us",
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 55,
          margin: const EdgeInsets.only(top: 10, bottom: 25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: kGreyColor.withOpacity(.2),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              context.read<AuthCubit>().signOut(context);
            },
            child: Center(
              child: Text(
                "Log Out",
                style: blackTextStyle.copyWith(
                  color: Colors.red,
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/setting_item.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appBarSection() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left,
                color: kBlackColor,
              ),
            )
          ],
        ),
      );
    }

    Widget header() {
      return Container(
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(
          top: 10,
          bottom: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(right: 20),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/img_avatar.png"),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: blackTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                Text(
                  "Acep nurman sidik",
                  style: blackTextStyle.copyWith(
                      fontSize: 18, fontWeight: semibold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "acepnurmansidik@gmail.com",
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget listItem() {
      return Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingItem(
              title: 'Help',
              iconMark: Icons.help_outline,
              onPressed: () {},
            ),
            SettingItem(
              title: 'Scan Code QR',
              iconMark: Icons.qr_code_scanner_outlined,
              onPressed: () {},
            ),
            SettingItem(
              title: 'Exit',
              isActive: true,
              iconMark: Icons.exit_to_app_outlined,
              onPressed: () async {
                AndroidOptions getAndroidOptions() => const AndroidOptions(
                      encryptedSharedPreferences: true,
                    );
                final storage =
                    FlutterSecureStorage(aOptions: getAndroidOptions());
                await storage.delete(key: 'token');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/sign-in', (route) => false);
              },
            ),
          ],
        ),
      );
    }

    Widget versionApp() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "v1.2.7",
              style: greyTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            Text(
              "acep copyright 2024",
              style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: appBarSection()),
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          versionApp(),
          ListView(
            children: [
              header(),
              listItem(),
            ],
          ),
        ],
      ),
    );
  }
}

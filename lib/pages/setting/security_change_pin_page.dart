// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';

class SecurityChangePinPage extends StatefulWidget {
  const SecurityChangePinPage({super.key});

  @override
  State<SecurityChangePinPage> createState() => _SecurityChangePinPageState();
}

class _SecurityChangePinPageState extends State<SecurityChangePinPage> {
  TextEditingController pinController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBaseColor,
      appBar: _buildAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _pinOutputSection(),
            _pinInputSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      surfaceTintColor: kSecondBaseColor,
      backgroundColor: kSecondBaseColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              toTitleCase("Enter your PIN"),
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _pinOutputSection() {
    Widget pinItem({index, EdgeInsets margin = EdgeInsets.zero}) {
      return Container(
        height: 18,
        width: 18,
        margin: margin,
        decoration: BoxDecoration(
          color: pinController.text.length >= 7
              ? Colors.red[500]
              : pinController.text.length >= index
                  ? kPrimaryV2Color
                  : kGreyColor.withOpacity(.2),
          shape: BoxShape.circle,
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pinItem(index: 1, margin: const EdgeInsets.only(right: 10)),
              pinItem(index: 2, margin: const EdgeInsets.only(right: 10)),
              pinItem(index: 3, margin: const EdgeInsets.only(right: 10)),
              pinItem(index: 4, margin: const EdgeInsets.only(right: 10)),
              pinItem(index: 5, margin: const EdgeInsets.only(right: 10)),
              pinItem(index: 6),
            ],
          ),
          const SizedBox(height: 15),
          if (pinController.text.length >= 7)
            Text(
              'PIN must be a maximum of 6 digits!',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
                color: Colors.red[500],
              ),
            ),
          const SizedBox(height: 25),
          Text(
            'Forgot PIN',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semibold,
              color: kPrimaryV2Color,
            ),
          )
        ],
      ),
    );
  }

  Widget _pinInputSection() {
    final containerHeight = MediaQuery.of(context).size.height / 1.666;
    const crossAxisCount = 3;
    const totalItems = 12;
    final rowCount = (totalItems / crossAxisCount).ceil(); // jumlah baris
    final itemHeight = containerHeight / rowCount;

    return SizedBox(
      height: containerHeight,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio:
                (MediaQuery.of(context).size.width / crossAxisCount) /
                    itemHeight),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                // BIOMETRIC BUTTON
                if (index == 9) {
                  return;
                }

                // BACKSPACE BUTTOM
                if (index == 11) {
                  if (pinController.text.isNotEmpty) {
                    // Hapus karakter terakhir
                    pinController.text = pinController.text
                        .substring(0, pinController.text.length - 1);
                  }

                  // Jika panjang lebih dari 6, ambil hanya 5 karakter pertama
                  if (pinController.text.length >= 6) {
                    pinController.text = pinController.text.substring(0, 5);
                  }

                  return;
                }

                if (index == 11 && pinController.text.isEmpty) {
                  return;
                }

                pinController.text = pinController.text +
                    (index == 10 ? "0" : (index + 1).toString());
              });
            },
            child: index == 9
                ? SizedBox(
                    child: Center(
                      child: Icon(
                        Icons.fingerprint,
                        color: kPrimaryV2Color,
                        size: 35,
                      ),
                    ),
                  )
                : index == 11
                    ? SizedBox(
                        child: Center(
                          child: Icon(
                            Icons.backspace_outlined,
                            color: kPrimaryV2Color,
                            size: 35,
                          ),
                        ),
                      )
                    : SizedBox(
                        child: Center(
                          child: Text(
                            '${index == 10 ? "0" : index + 1}',
                            style: blackTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: bold,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }
}

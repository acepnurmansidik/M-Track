import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class FormTransactionPage extends StatefulWidget {
  const FormTransactionPage({super.key});

  @override
  State<FormTransactionPage> createState() => _FormTransactionPageState();
}

class _FormTransactionPageState extends State<FormTransactionPage> {
  String? selectedValue; // Variabel untuk menyimpan nilai yang dipilih
  final List<String> items = ['Item 1', 'Item 2', 'Item 3']; // Daftar item

  int selectedBoxType = 0;
  // Text form
  final TextEditingController amountlController =
      TextEditingController(text: "");
  final TextEditingController typeIdController =
      TextEditingController(text: "");
  final TextEditingController categoryIdController =
      TextEditingController(text: "");
  final TextEditingController notesIdController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget appBarSection() {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
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

    Widget nominalSection() {
      return Container(
        width: double.infinity,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: kWhiteColor,
        ),
        child: Column(
          children: [
            CustomeTextFormFieldItem(
              controller: amountlController,
              title: "Nominal",
              isNumberOnly: true,
              hintText: "0",
            ),
          ],
        ),
      );
    }

    Widget balanceInfoSection() {
      return Container(
        width: MediaQuery.of(context).size.width - (2 * 20),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: BorderSide(color: kPrimaryV2Color, width: 2),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    NumberFormat.currency(symbol: "Rp. ", decimalDigits: 0)
                        .format(7000000),
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.remove_red_eye,
                color: kGreyColor,
              ),
            ]),
      );
    }

    Widget additionalSections() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.93,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(color: kWhiteColor),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.create,
                    color: kGreyColor,
                    size: 22,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Tambah Keterangan",
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              width: MediaQuery.of(context).size.width,
              color: kGreyColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBoxType = 1;
                    });
                  },
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: selectedBoxType == 1 ? 2 : 1.3,
                        color:
                            selectedBoxType == 1 ? kPrimaryV2Color : kGreyColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Income",
                        style: selectedBoxType == 1
                            ? primaryTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semibold,
                              )
                            : blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBoxType = 2;
                    });
                  },
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: selectedBoxType == 2 ? 2 : 1.3,
                        color:
                            selectedBoxType == 2 ? kPrimaryV2Color : kGreyColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Outcome",
                        style: selectedBoxType == 2
                            ? primaryTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semibold,
                              )
                            : blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      color: kGreyColor,
                      fontWeight: medium,
                    ),
                  ),
                  DropdownButtonFormField(
                    dropdownColor: kWhiteColor,
                    value: selectedValue,
                    decoration: InputDecoration(
                        border:
                            InputBorder.none, // Menghilangkan border default
                        filled: true,
                        fillColor: kWhiteColor, // Warna latar belakang dropdown
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10) // Padding
                        ),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: const Text("-"),
                    items: items.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              title: 'Submit',
              margin: const EdgeInsets.symmetric(vertical: 10),
              onPressed: () {},
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      body: ListView(
        children: [
          nominalSection(),
          balanceInfoSection(),
          additionalSections(),
        ],
      ),
    );
  }
}

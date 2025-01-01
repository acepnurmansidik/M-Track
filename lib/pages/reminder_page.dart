// ignore_for_file: unnecessary_null_comparison, unused_element, unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/refparamater_cubit.dart';
import 'package:tracking/cubit/wallet_cubit.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class ReminderPage extends StatefulWidget {
  final TrxItemModel? transactions;

  const ReminderPage({super.key, this.transactions});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  String? selectedValue; // Variabel untuk menyimpan nilai yang dipilih
  List<DropdownMenuItem>? categories;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _controllerCarousel = CarouselSliderController();
  bool isIncome = true;
  int currentIndexDate = 0;

  bool showNotes = false;

  // Text form
  final TextEditingController bankIdController =
      TextEditingController(text: "");
  final TextEditingController typeIdController =
      TextEditingController(text: "");
  final TextEditingController categoryIdController =
      TextEditingController(text: "");
  final TextEditingController notesIdController =
      TextEditingController(text: "");
  final CurrencyTextFieldController amountController =
      CurrencyTextFieldController(
    showZeroValue: true,
    currencySymbol: "Rp",
    currencySeparator: ". ",
    numberOfDecimals: 0,
    initDoubleValue: 0.0,
  );

  @override
  void initState() {
    super.initState();

    if (widget.transactions != null) {
      typeIdController.text = widget.transactions!.typeId["_id"];
      categoryIdController.text = widget.transactions!.categoryId["_id"];
      bankIdController.text = widget.transactions!.bankId?["_id"];
      notesIdController.text = widget.transactions!.note;
      amountController.text = widget.transactions!.amount.toString();
    }

    context
        .read<RefparamaterCubit>()
        .getRefparam(parentId: typeIdController.text);
    context.read<WalletCubit>().fetchWalletList();
  }

  final List<String> dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final List<String> dropdownRepeatItems = [
    'Weekly',
    'Monthly',
    'Yearly',
  ];

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
              child: Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: kBlackColor,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget categorySection() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isIncome = !isIncome;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 55,
                width: 55,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhiteColor,
                  border: Border.all(
                    color: isIncome ? kGreenColor : kRedColor,
                    width: .7,
                  ),
                ),
                child: Text(
                  isIncome ? "IN" : "OUT",
                  style: isIncome
                      ? greenTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        )
                      : redTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width - 110,
              child: DropdownButtonFormField(
                dropdownColor: kWhiteColor,
                value: selectedValue,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: const Text("-"),
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text("Category"),
                  border: InputBorder.none,
                  focusColor: kWhiteColor,
                  filled: true,
                  fillColor: kWhiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      );
    }

    Widget formSection() {
      return Container(
        margin: const EdgeInsets.only(bottom: 75),
        child: Column(
          children: [
            CustomeTextFormFieldItem(
              controller: notesIdController,
              title: 'Title',
              isNumberOnly: false,
              hintText: 'Enter title reminder',
              validateFunc: (value) {
                return null;
              },
            ),
            CustomeTextFormFieldItem(
              controller: amountController,
              fontSize: 30,
              fontWeight: bold,
              title: "Nominal",
              isNumberOnly: true,
              hintText: "0",
              validateFunc: (value) {
                final result = value!.split("Rp. ").length == 2
                    ? value.split("Rp. ")[1]
                    : value;
                if (value == null || value.isEmpty || result == "0") {
                  return 'Field nominal cannot be empty';
                }
                return null; // Return null if valid
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Repeat",
                    style: secondaryTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 12,
                      color: kGreyColor,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(right: 5),
                      child: CarouselSlider(
                        carouselController: _controllerCarousel,
                        options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          height: 50,
                          viewportFraction: .55,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndexDate = index;
                            });
                          },
                        ),
                        items: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child: Text(
                              "01",
                              style: currentIndexDate == 0
                                  ? primaryTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    )
                                  : blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child: Text(
                              "02",
                              style: currentIndexDate == 1
                                  ? primaryTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    )
                                  : blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 105,
                      child: DropdownButtonFormField(
                        dropdownColor: kWhiteColor,
                        value: selectedValue,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text("-"),
                        items: dropdownRepeatItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text("Every"),
                          border: InputBorder.none,
                          focusColor: kWhiteColor,
                          filled: true,
                          fillColor: kWhiteColor,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    Widget buttonSubmitSection() {
      return CustomButton(
        title: 'Submit',
        margin: const EdgeInsets.symmetric(vertical: 10),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Jika validasi berhasil, lakukan sesuatu
            // if (typeIdController.text.isNotEmpty) {
            //   context.read<TransactionCubit>().postTrx({
            //     "amount": amountController.intValue.toString(),
            //     "type_id": typeIdController.text,
            //     "bank_id": bankIdController.text,
            //     "category_id": categoryIdController.text,
            //     "note": notesIdController.text,
            //   });
            // }
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 55),
        child: appBarSection(),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
          children: [
            categorySection(),
            formSection(),
            buttonSubmitSection(),
          ],
        ),
      ),
    );
  }
}

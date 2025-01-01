// ignore_for_file: unnecessary_null_comparison

import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({super.key});

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController fromController = TextEditingController(text: "You");
  TextEditingController toController = TextEditingController(text: "Me");
  TextEditingController notesController = TextEditingController();
  final CurrencyTextFieldController amountController =
      CurrencyTextFieldController(
    showZeroValue: true,
    currencySymbol: "Rp",
    currencySeparator: ". ",
    numberOfDecimals: 0,
    initDoubleValue: 0.0,
  );
  bool _isSwitch = true;

  void _toggleSwitch() {
    setState(() {
      _isSwitch = !_isSwitch;
      final tempName = toController.text;
      toController.text = fromController.text;
      fromController.text = tempName;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget fieldInputName({
      borderSizeTop = .5,
      borderSizeBottom = .5,
      isTop = true,
      controller,
      double bottomLeftRadius = 0,
      double bottomRightRadius = 0,
      double topLeftRadius = 0,
      double topRightRadius = 0,
    }) {
      return Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          margin: EdgeInsets.only(
            right: isTop ? 30 : 0,
            left: isTop ? 0 : 30,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: borderSizeTop,
                color: kGreyColor.withOpacity(.5),
              ),
              bottom: BorderSide(
                width: borderSizeBottom,
                color: kGreyColor.withOpacity(.5),
              ),
              left: BorderSide(
                width: 1.2,
                color: kGreyColor.withOpacity(.5),
              ),
              right: BorderSide(
                width: 1.2,
                color: kGreyColor.withOpacity(.5),
              ),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
              topRight: Radius.circular(topRightRadius),
              topLeft: Radius.circular(topLeftRadius),
            ),
          ),
          child: TextFormField(
            controller: controller,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semibold,
            ),
            decoration: InputDecoration(
              hintText: "Enter name",
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryV2Color, width: 2),
              ),
              errorStyle: redTextStyle.copyWith(
                fontSize: 10,
              ),
              errorMaxLines: 1,
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
      );
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: kWhiteColor,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    fieldInputName(
                      borderSizeTop: 1.2,
                      isTop: _isSwitch ? true : false,
                      controller: fromController,
                      topLeftRadius: 18,
                      topRightRadius: 18,
                    ),
                    fieldInputName(
                      borderSizeBottom: 1.2,
                      isTop: _isSwitch ? false : true,
                      controller: toController,
                      bottomLeftRadius: 18,
                      bottomRightRadius: 18,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 25,
                        color: kWhiteColor,
                        child: Text(
                          'to',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: semibold),
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleSwitch,
                        child: Transform.rotate(
                          angle: _isSwitch ? 3.141592653589793238 : 0,
                          child: Container(
                            height: 45,
                            width: 45,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kWhiteColor,
                              border: Border.all(
                                width: 1.5,
                                color: kGreyColor.withOpacity(.8),
                              ),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/exchange.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            CustomeTextFormFieldItem(
              controller: notesController,
              title: 'Note',
              isNumberOnly: false,
              hintText: 'Enter notes',
              validateFunc: (value) {
                return null;
              },
            ),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Submit',
              margin: const EdgeInsets.symmetric(vertical: 10),
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
            )
          ],
        ),
      ),
    );
  }
}

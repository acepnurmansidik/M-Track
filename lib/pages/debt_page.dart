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
  TextEditingController from = TextEditingController();
  final CurrencyTextFieldController amountController =
      CurrencyTextFieldController(
    showZeroValue: true,
    currencySymbol: "Rp",
    currencySeparator: ". ",
    numberOfDecimals: 0,
    initDoubleValue: 0.0,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: kWhiteColor,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
          children: [
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
              controller: from,
              title: 'From',
              isNumberOnly: false,
              hintText: 'of whom',
              validateFunc: (value) {
                return null;
              },
            ),
            CustomeTextFormFieldItem(
              controller: from,
              title: 'To',
              isNumberOnly: false,
              hintText: 'to whom',
              validateFunc: (value) {
                return null;
              },
            ),
            CustomeTextFormFieldItem(
              controller: from,
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

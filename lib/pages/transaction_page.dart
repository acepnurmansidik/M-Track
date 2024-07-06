import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_dropdown_item.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController amountController =
      TextEditingController(text: "");
  final TextEditingController noteController = TextEditingController(text: "");
  final TextEditingController categoryController =
      TextEditingController(text: "");
  final TextEditingController typeController = TextEditingController(text: "");

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

    Widget formSection() {
      return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownItem(
              title: "Category",
              selectItem: categoryController,
            ),
            CustomDropdownItem(
              title: "Type",
              selectItem: typeController,
            ),
            CustomeTextFormFieldItem(
                controller: amountController,
                title: "Amount",
                isNumberOnly: true,
                hintText: "Enter total amount"),
            CustomeTextFormFieldItem(
                controller: noteController,
                title: "Note",
                isNumberOnly: false,
                hintText: "Enter description"),
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return CustomButton(
        title: 'Submit',
        margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/success', (route) => false);
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      body: ListView(
        children: [formSection(), buttonSubmit()],
      ),
    );
  }
}

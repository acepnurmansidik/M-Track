import 'package:flutter/material.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_dropdown_item.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class TransactionPage extends StatefulWidget {
  late TransactionModel transaction;

  TransactionPage({
    super.key,
    this.transaction = const TransactionModel(
      amount: 0,
      note: "",
      categoryId: {},
      typeId: {},
      createdAt: "",
    ),
  });

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
  void initState() {
    amountController.text = widget.transaction.amount.toString() != ""
        ? widget.transaction.amount.toString()
        : "";
    noteController.text =
        widget.transaction.note != "" ? widget.transaction.note : "";
    categoryController.text = widget.transaction.categoryId == null
        ? widget.transaction.categoryId["_id"]
        : "";
    typeController.text = widget.transaction.typeId == null
        ? widget.transaction.typeId["_id"]
        : "";
    super.initState();
  }

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
        margin: EdgeInsets.only(top: 5),
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
              hintText: "Enter total amount",
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            CustomeTextFormFieldItem(
              controller: noteController,
              title: "Note",
              isNumberOnly: false,
              hintText: "Enter description",
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return CustomButton(
        title: 'Submit',
        margin: EdgeInsets.only(left: 20, right: 20, top: 50),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/success', (route) => false);
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60), child: appBarSection()),
      body: ListView(
        children: [formSection(), buttonSubmit()],
      ),
    );
  }
}

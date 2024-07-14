import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/refparamater_cubit.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_dropdown_item.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class TransactionPage extends StatefulWidget {
  final bool isEditBtn;
  late TrxItemModel transaction;

  TransactionPage({
    super.key,
    this.isEditBtn = true,
    this.transaction = const TrxItemModel(
      amount: 0,
      totalAmount: 0,
      kursAmount: 0,
      note: "",
      categoryId: {},
      kursId: {},
      typeId: {},
      datetime: "",
    ),
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController amountController =
      TextEditingController(text: "");
  final TextEditingController kursAmountController =
      TextEditingController(text: "");
  final TextEditingController kursIdAmountController =
      TextEditingController(text: "");
  final TextEditingController noteController = TextEditingController(text: "");
  final TextEditingController categoryController =
      TextEditingController(text: "");
  final TextEditingController typeController = TextEditingController(text: "");

  int _itemsSecondDropDown = -1;
  int _showKursAmount = -1;

  @override
  void initState() {
    amountController.text = widget.transaction.amount.toString() != ""
        ? widget.transaction.amount.toString()
        : "";
    kursAmountController.text = widget.transaction.kursAmount.toString() != ""
        ? widget.transaction.kursAmount.toString()
        : "1";
    noteController.text =
        widget.transaction.note != "" ? widget.transaction.note : "";

    // Init _id section
    categoryController.text = widget.transaction.categoryId["_id"] != null
        ? widget.transaction.categoryId["_id"]
        : "";
    typeController.text = widget.transaction.typeId["_id"] != null
        ? widget.transaction.typeId["_id"]
        : "";

    context.read<RefparamaterCubit>().getRefparamTypeCategory();
    context.read<RefparamaterCubit>().getRefKurs();
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
            BlocBuilder<RefparamaterCubit, RefparamaterState>(
              builder: (context, state) {
                if (state is RefparamaterSuccess) {
                  return Column(
                    children: [
                      CustomDropdownItem(
                        title: "Type",
                        selectItem: typeController,
                        items: state.refparam,
                        onChange: (value) {
                          setState(() {
                            _itemsSecondDropDown = value;
                          });
                        },
                      ),
                      if (_itemsSecondDropDown > -1)
                        CustomDropdownItem(
                          title: "Category",
                          selectItem: categoryController,
                          items: state.refparam[_itemsSecondDropDown].items,
                          onChange: (value) {},
                        ),
                    ],
                  );
                }
                return Column(
                  children: [
                    CustomDropdownItem(
                      title: "Type",
                      selectItem: typeController,
                      items: [],
                      onChange: (value) {
                        setState(() {
                          _itemsSecondDropDown = value;
                        });
                      },
                    ),
                    if (_itemsSecondDropDown > -1)
                      CustomDropdownItem(
                        title: "Category",
                        selectItem: categoryController,
                        items: [],
                        onChange: (value) {},
                      ),
                  ],
                );
              },
            ),
            BlocBuilder<RefparamaterCubit, RefparamaterState>(
              builder: (context, state) {
                if (state is RefparamaterSuccess) {
                  return CustomDropdownItem(
                    title: "Kurs",
                    selectItem: kursIdAmountController,
                    items: state.refparam,
                    onChange: (value) {
                      setState(() {
                        _showKursAmount = 1;
                      });
                    },
                  );
                }
                return CustomDropdownItem(
                  title: "Kurs",
                  selectItem: kursIdAmountController,
                  items: [],
                  onChange: (value) {
                    setState(() {
                      _showKursAmount = 1;
                    });
                  },
                );
              },
            ),
            if (_showKursAmount > -1)
              CustomeTextFormFieldItem(
                controller: kursAmountController,
                title: "Kurs amount",
                isNumberOnly: true,
                hintText: "Enter kurs exchange",
                padding: EdgeInsets.symmetric(horizontal: 20),
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
      return BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionActionSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/success', (route) => false);
          } else if (state is TransactionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: kRedColor, content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return CustomButton(
            title: 'Submit',
            margin: const EdgeInsets.only(
                left: 20, right: 20, top: 50, bottom: 100),
            onPressed: () {
              if (widget.isEditBtn) {
                context.read<TransactionCubit>().putTrx(widget.transaction.id, {
                  "category_id": categoryController.text,
                  "type_id": typeController.text,
                  "kurs_id": "669365e02c2c9f9c783752b2",
                  "amount": amountController.text,
                  "kurs_amount": kursAmountController.text,
                  "note": noteController.text
                });
              } else {
                context.read<TransactionCubit>().postTrx({
                  "category_id": categoryController.text,
                  "type_id": typeController.text,
                  "kurs_id": "669365e02c2c9f9c783752b2",
                  "amount": amountController.text,
                  "kurs_amount": kursAmountController.text,
                  "note": noteController.text
                });
              }
            },
          );
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

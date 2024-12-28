import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/refparamater_cubit.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_dropdown_item.dart';
import 'package:tracking/widgets/custom_textform_field.dart';
import 'package:tracking/widgets/loading_animation.dart';

class TransactionPage extends StatefulWidget {
  final bool isEditBtn;
  final TrxItemModel transaction;

  const TransactionPage({
    super.key,
    this.isEditBtn = true,
    this.transaction = const TrxItemModel(
      amount: 0,
      totalAmount: 0,
      kursAmount: 0,
      isIncome: false,
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
    kursIdAmountController.text = widget.transaction.kursId["_id"] ?? "";
    categoryController.text = widget.transaction.categoryId["_id"] ?? "";
    typeController.text = widget.transaction.typeId["_id"] ?? "";

    context.read<RefparamaterCubit>().getRefparam();
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
      return BlocBuilder<RefparamaterCubit, RefparamaterState>(
        builder: (context, state) {
          if (state is RefparamaterSuccess) {
            return Container(
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CustomDropdownItem(
                      //   width: 80,
                      //   title: "Kurs",
                      //   selectItem: kursIdAmountController,
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   items: state.reffKurs[0].items,
                      //   onChange: (value) {},
                      // ),
                      CustomeTextFormFieldItem(
                        width: MediaQuery.of(context).size.width - (2 * 60),
                        controller: kursAmountController,
                        title: "Kurs Amount",
                        isNumberOnly: true,
                        hintText: "Enter total amount",
                        padding: const EdgeInsets.only(right: 20),
                        validateFunc: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                  CustomDropdownItem(
                    title: "Type",
                    selectItem: typeController,
                    items: state.listCategoryTypeReff,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      items: state
                          .listCategoryTypeReff[_itemsSecondDropDown].items,
                      onChange: (value) {},
                    ),
                  CustomeTextFormFieldItem(
                    controller: amountController,
                    title: "Amount",
                    isNumberOnly: true,
                    hintText: "Enter total amount",
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    validateFunc: (value) {
                      return null;
                    },
                  ),
                  CustomeTextFormFieldItem(
                    controller: noteController,
                    title: "Note",
                    isNumberOnly: false,
                    hintText: "Enter description",
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    validateFunc: (value) {
                      return null;
                    },
                  ),
                ],
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomDropdownItem(
                      width: 80,
                      title: "Kurs",
                      selectItem: kursIdAmountController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      items: const [],
                      onChange: (value) {},
                    ),
                    CustomeTextFormFieldItem(
                      width: MediaQuery.of(context).size.width - (2 * 60),
                      controller: amountController,
                      title: "Kurs Amount",
                      isNumberOnly: true,
                      hintText: "Enter total amount",
                      padding: const EdgeInsets.only(right: 20),
                      validateFunc: (value) {
                        return null;
                      },
                    ),
                  ],
                ),
                CustomDropdownItem(
                  title: "Type",
                  selectItem: typeController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  items: const [],
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    items: const [],
                    onChange: (value) {},
                  ),
                CustomeTextFormFieldItem(
                  controller: amountController,
                  title: "Amount",
                  isNumberOnly: true,
                  hintText: "Enter total amount",
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  validateFunc: (value) {
                    return null;
                  },
                ),
                CustomeTextFormFieldItem(
                  controller: noteController,
                  title: "Note",
                  isNumberOnly: false,
                  hintText: "Enter description",
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  validateFunc: (value) {
                    return null;
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionCreateSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/success', (route) => false);
          } else if (state is TransactionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: kRedColor, content: Text(state.error)));
          } else if (state is TransactionLoading) {
            const LoadingAnimation();
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              formSection(),
              CustomButton(
                title: 'Submit',
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 50, bottom: 100),
                onPressed: () {
                  // if (widget.isEditBtn) {
                  //   context
                  //       .read<TransactionCubit>()
                  //       .putTrx(widget.transaction.id, {
                  //     "category_id": categoryController.text,
                  //     "type_id": typeController.text,
                  //     "kurs_id": kursIdAmountController.text,
                  //     "amount": amountController.text,
                  //     "kurs_amount": kursAmountController.text,
                  //     "note": noteController.text
                  //   });
                  // } else {
                  //   context.read<TransactionCubit>().postTrx({
                  //     "category_id": categoryController.text,
                  //     "type_id": typeController.text,
                  //     "kurs_id": kursIdAmountController.text,
                  //     "amount": amountController.text,
                  //     "kurs_amount": kursAmountController.text,
                  //     "note": noteController.text
                  //   });
                  // }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

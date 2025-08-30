// ignore_for_file: unnecessary_null_comparison

import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/reffparam/reffparam_cubit.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/pages/cards/wallet_item.dart';
import 'package:tracking/pages/dashboard/cubit/transaction_cubit.dart';
import 'package:tracking/pages/dashboard/cubit/wallet_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/utils/others.dart';
import 'package:tracking/widgets/custom_textform_field_underline.dart';

class FormCashflowPage extends StatefulWidget {
  final TransactionDaum? transaction;
  final bool isEdit;
  const FormCashflowPage({super.key, this.isEdit = false, this.transaction});

  @override
  State<FormCashflowPage> createState() => _FormCashflowPageState();
}

class _FormCashflowPageState extends State<FormCashflowPage> {
  String? selectedValue; // Variabel untuk menyimpan nilai yang dipilih
  bool showNotes = false; // Variabel untuk menyimpan nilai yang dipilih
  int selectedCategoryIndex = 0; // Variabel untuk menyimpan nilai yang dipilih
  List<DropdownMenuItem>? categoryChildrens;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController notesIdController =
      TextEditingController(text: "");
  final TextEditingController typeIdController =
      TextEditingController(text: "");
  final TextEditingController categoryIdController =
      TextEditingController(text: "");
  final TextEditingController walletIdController =
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
    context.read<ReffparamCubit>().fetchReffParam();
    setState(() {
      walletIdController.text =
          context.read<WalletCubit>().state.props[2].toString();
    });
    super.initState();
  }

  void _changeTypeCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: _buildAppBar("cashflow"),
      body: Form(
        key: _formKey,
        child: Stack(children: [
          ListView(
            children: [
              _nominalSection(),
              _cardSection(),
              _submitSection(),
              _authSection(),
            ],
          ),
          if (showNotes) _modalAddNote()
        ]),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: kBaseColors,
      surfaceTintColor: kBaseColors,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              toTitleCase(title),
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _nominalSection() {
    return Container(
      width: double.infinity,
      height: 144,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: kWhiteColor,
      ),
      child: Column(
        children: [
          CustomTextformFieldUnderline(
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
        ],
      ),
    );
  }

  Widget _cardSection() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        left: defaultMargin,
        right: defaultMargin,
      ),
      height: 200,
      child: Stack(
        children: [
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
                return const Text('Wallet Loading');
              } else if (state is WalletSuccess) {
                return WalletItem(
                  nominal: state.walletSelected.amount,
                  vaNumber: state.walletSelected.vaNumber,
                  number: state.walletSelected.number,
                  exp: state.walletSelected.exp,
                  currency:
                      state.walletSelected.currencyId.value!.toUpperCase(),
                );
              }
              return WalletItem();
            },
          ),
          GestureDetector(
            onTap: () {},
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 45,
                width: 130,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kBlackColor,
                ),
                child: Text(
                  "Swipe",
                  style: whiteTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: kWhiteColor),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showNotes = true;
              });
            },
            child: Container(
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
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            width: MediaQuery.of(context).size.width,
            color: kGreyColor,
          ),
          BlocBuilder<ReffparamCubit, ReffparamState>(
            builder: (context, state) {
              if (state is ReffparamLoading) {
              } else if (state is ReffparamSuccess) {
                // Jika typeIdController.text kosong, set ke nilai pertama
                if (typeIdController.text.isEmpty) {
                  typeIdController.text = state.data.data.first.sId;
                }

                var childrens = state.data.data[selectedCategoryIndex].children;
                return SizedBox(
                  child: Column(
                    children: [
                      // NOTES: LOOPING CATEGORY
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            state.data.data.asMap().entries.map((everyItem) {
                          return GestureDetector(
                            onTap: () => _changeTypeCategory(everyItem.key),
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: selectedCategoryIndex == everyItem.key
                                      ? 2
                                      : 1.3,
                                  color: selectedCategoryIndex == everyItem.key
                                      ? kPrimaryV2Color
                                      : kGreyColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  toTitleCase(everyItem.value.value),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight:
                                        selectedCategoryIndex == everyItem.key
                                            ? semibold
                                            : medium,
                                    color:
                                        selectedCategoryIndex == everyItem.key
                                            ? kPrimaryV2Color
                                            : kBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // NOTES: DATA CHILDREN
                      Container(
                        height: 103,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
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
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a category';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: kWhiteColor,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                              ),
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: const Text("--Choose category--"),
                              items: childrens.map((categoryItem) {
                                return DropdownMenuItem(
                                  value: categoryItem.sId.toString(),
                                  child: Text(categoryItem.value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value.toString();
                                  categoryIdController.text = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.93 - 111,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: kPrimaryV2Color,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Income",
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _authSection() {
    return GestureDetector(
      onTap: () {
        final body = {
          "total_amount": amountController.intValue.toString(),
          "type_id": typeIdController.text,
          "wallet_id": walletIdController.text,
          "category_id": categoryIdController.text,
          "note": notesIdController.text,
        };
        if (_formKey.currentState!.validate()) {
          // Jika validasi berhasil, lakukan sesuatu
          if (typeIdController.text.isNotEmpty && !widget.isEdit) {
            context.read<TransactionCubit>().createTransaction(body);
          } else if (typeIdController.text.isNotEmpty &&
              widget.isEdit == true) {
            context
                .read<TransactionCubit>()
                .updateTransaction(widget.transaction!.sId, body);
          }
        }
      },
      child: Container(
        height: 55,
        margin: EdgeInsets.only(
          bottom: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kPrimaryV2Color,
        ),
        child: Text(
          "Submit",
          style: blackTextStyle.copyWith(
            color: kWhiteColor,
            fontWeight: bold,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _modalAddNote() {
    return SizedBox.expand(
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            setState(() {
              showNotes = false;
            });
          }
          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0,
          maxChildSize: 0.4,
          shouldCloseOnMinExtent: false,
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tambah Keterangan",
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semibold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showNotes = false;
                            });
                          },
                          child: Icon(
                            Icons.close,
                            size: 27,
                            color: kGreyColor,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryV2Color,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextFormField(
                        maxLines: 2,
                        controller: notesIdController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Keterangan",
                          border: InputBorder.none,
                          fillColor: kGreyColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 35,
                      margin: EdgeInsets.zero,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showNotes = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: kPrimaryV2Color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: whiteTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

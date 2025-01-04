// ignore_for_file: unnecessary_null_comparison

import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/wallet_cubit.dart';
import 'package:tracking/models/wallet_model.dart';
import 'package:tracking/pages/success_page.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class FormBankAccountPage extends StatefulWidget {
  final WalletModel? wallet;
  final bool? isEdit;

  const FormBankAccountPage({super.key, this.isEdit, this.wallet});

  @override
  State<FormBankAccountPage> createState() => _FormBankAccountPageState();
}

class _FormBankAccountPageState extends State<FormBankAccountPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController ownerNameController = TextEditingController(text: "");
  TextEditingController vaWalletNameController =
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

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 55),
        child: appBarSection(),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: 106,
              width: MediaQuery.of(context).size.width,
              child: CustomeTextFormFieldItem(
                controller: ownerNameController,
                title: 'Owner Name',
                isNumberOnly: false,
                hintText: 'Enter your owner name',
                validateFunc: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your owner name';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 106,
              width: MediaQuery.of(context).size.width,
              child: CustomeTextFormFieldItem(
                controller: vaWalletNameController,
                title: 'VA Name',
                isNumberOnly: false,
                hintText: 'Enter va name',
                validateFunc: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your va name';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 139,
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
              child: Column(
                children: [
                  CustomeTextFormFieldItem(
                    controller: amountController,
                    fontSize: 30,
                    fontWeight: bold,
                    title: "Balance",
                    isNumberOnly: true,
                    hintText: "0",
                    validateFunc: (value) {
                      final result = value!.split("Rp. ").length == 2
                          ? value.split("Rp. ")[1]
                          : value;
                      if (value == null || value.isEmpty || result == "0") {
                        return 'Field balance cannot be empty';
                      }
                      return null; // Return null if valid
                    },
                  ),
                ],
              ),
            ),
            BlocConsumer<WalletCubit, WalletState>(
              listener: (context, state) {
                if (state is WalletSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessPage(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is WalletLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  title: 'Submit',
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final body = {
                        "owner_name": ownerNameController.text,
                        "wallet_name": vaWalletNameController.text,
                        "amount": amountController.intValue.toString()
                      };

                      // check is edit form or not
                      if (widget.isEdit == true) {
                        context.read<WalletCubit>().putWallet(body);
                      } else {
                        context.read<WalletCubit>().postWallet(body);
                      }
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

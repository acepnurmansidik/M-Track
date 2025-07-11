// ignore_for_file: unnecessary_null_comparison

import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/cubit/loan_cubit.dart';
import 'package:tracking/models/loan_model.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class FormLoanPage extends StatefulWidget {
  final LoanModel? dataLoan;
  final bool isEdit;

  const FormLoanPage({super.key, this.dataLoan, this.isEdit = false});

  @override
  State<FormLoanPage> createState() => _FormLoanPageState();
}

class _FormLoanPageState extends State<FormLoanPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController fromController = TextEditingController(text: "You");
  TextEditingController toController = TextEditingController(text: "");
  TextEditingController notesController = TextEditingController(text: "");
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
  void initState() {
    super.initState();
    if (widget.dataLoan != null) {
      toController.text = widget.dataLoan!.toName;
      fromController.text = widget.dataLoan!.fromName;
      notesController.text = widget.dataLoan!.note;
      amountController.text = widget.dataLoan!.nominal.toString();
    }
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(
            right: isTop ? 30 : 0,
            left: isTop ? 0 : 30,
          ),
          child: TextFormField(
            controller: controller,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semibold,
            ),
            decoration: InputDecoration(
              hintText: "Enter name",
              focusColor: Colors.transparent,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeftRadius),
                  bottomRight: Radius.circular(bottomRightRadius),
                  topRight: Radius.circular(topRightRadius),
                  topLeft: Radius.circular(topLeftRadius),
                ),
                borderSide: BorderSide(color: kPrimaryV2Color, width: 2),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeftRadius),
                  bottomRight: Radius.circular(bottomRightRadius),
                  topRight: Radius.circular(topRightRadius),
                  topLeft: Radius.circular(topLeftRadius),
                ),
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

    Widget buttonSubmit() {
      return BlocConsumer<LoanCubit, LoanState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoanLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomButton(
            title: 'Submit',
            margin: const EdgeInsets.only(top: 50),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final body = {
                  "from_name": fromController.text.toString(),
                  "to_name": toController.text.toString(),
                  "nominal": amountController.intValue.toString(),
                  "note": notesController.text.toString(),
                  "is_income": _isSwitch.toString()
                };
                if (widget.isEdit == false) {
                  context.read<LoanCubit>().postLoan(body);
                } else {
                  context.read<LoanCubit>().puttLoan(body, widget.dataLoan!.id);
                }
              }
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 55),
        child: appBarSection(),
      ),
      body: Container(
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      _isSwitch == true
                                          ? kGreenColor
                                          : kRedColor,
                                      BlendMode.srcIn,
                                    ),
                                    image:
                                        const AssetImage('assets/exchange.png'),
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
              buttonSubmit()
            ],
          ),
        ),
      ),
    );
  }
}

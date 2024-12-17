import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking/cubit/refparamater_cubit.dart';
import 'package:tracking/cubit/transaction_cubit.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/custom_button.dart';
import 'package:tracking/widgets/custom_textform_field.dart';

class FormTransactionPage extends StatefulWidget {
  const FormTransactionPage({super.key});

  @override
  State<FormTransactionPage> createState() => _FormTransactionPageState();
}

class _FormTransactionPageState extends State<FormTransactionPage> {
  String? selectedValue; // Variabel untuk menyimpan nilai yang dipilih
  List<DropdownMenuItem>? categories;
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool showNotes = false;

  int selectedIndexBoxType = 0;
  // Text form
  final TextEditingController amountlController =
      TextEditingController(text: "");
  final TextEditingController typeIdController =
      TextEditingController(text: "");
  final TextEditingController categoryIdController =
      TextEditingController(text: "");
  final TextEditingController notesIdController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    context.read<RefparamaterCubit>().getRefparam();
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
              child: Icon(
                Icons.chevron_left,
                color: kBlackColor,
              ),
            )
          ],
        ),
      );
    }

    Widget nominalSection() {
      return Container(
        width: double.infinity,
        height: 129,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: kWhiteColor,
        ),
        child: Column(
          children: [
            CustomeTextFormFieldItem(
              controller: amountlController,
              title: "Nominal",
              isNumberOnly: true,
              hintText: "0",
              validateFunc: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field nominal cannot be empty';
                }
                return null; // Return null if valid
              },
            ),
          ],
        ),
      );
    }

    Widget balanceInfoSection() {
      return Container(
        width: MediaQuery.of(context).size.width - (2 * 20),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: BorderSide(color: kPrimaryV2Color, width: 2),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    NumberFormat.currency(symbol: "IDR ", decimalDigits: 0)
                        .format(7000000),
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.remove_red_eye,
                color: kGreyColor,
              ),
            ]),
      );
    }

    Widget additionalSections() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.93,
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
            BlocBuilder<RefparamaterCubit, RefparamaterState>(
              builder: (context, state) {
                if (state is RefparamaterLoading) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.93 - 111,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Shimmer.fromColors(
                              baseColor: kLineDarkColor,
                              highlightColor: kWhiteColor,
                              child: Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kLineDarkColor,
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: kLineDarkColor,
                              highlightColor: kWhiteColor,
                              child: Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kLineDarkColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Shimmer.fromColors(
                          baseColor: kLineDarkColor,
                          highlightColor: kWhiteColor,
                          child: Container(
                            height: 15,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: kLineDarkColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: kLineDarkColor,
                          highlightColor: kWhiteColor,
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: kLineDarkColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Shimmer.fromColors(
                          baseColor: kLineDarkColor,
                          highlightColor: kWhiteColor,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 55,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kLineDarkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is RefparamaterSuccess) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.93 - 111,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: state.listCategoryTypeReff
                              .asMap()
                              .entries
                              .map((typeItem) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndexBoxType = typeItem.key;
                                  typeIdController.text = typeItem.value.id;
                                  selectedValue = null;
                                  // Memanggil refreshCategory
                                  context
                                      .read<RefparamaterCubit>()
                                      .refreshCategory(
                                          parentId: typeItem.value.id);
                                });
                              },
                              child: Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: selectedIndexBoxType == typeItem.key
                                        ? 2
                                        : 1.3,
                                    color: selectedIndexBoxType == typeItem.key
                                        ? kPrimaryV2Color
                                        : kGreyColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    typeItem.value.value,
                                    style: selectedIndexBoxType == typeItem.key
                                        ? primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semibold)
                                        : blackTextStyle.copyWith(
                                            fontSize: 16, fontWeight: medium),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        // Dropdown untuk kategori
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
                                    fontWeight: medium),
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
                                hint: const Text("-"),
                                items: categories ??
                                    state.listCategoryReff.map((catItem) {
                                      return DropdownMenuItem(
                                        value: catItem.id.toString(),
                                        child: Text(catItem.value),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value.toString();
                                    categoryIdController.text =
                                        value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        BlocConsumer<TransactionCubit, TransactionState>(
                          listener: (context, state) {
                            if (state is TransactionCreateSuccess) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/success',
                                (route) => false,
                              );
                            } else if (state is TransactionFailed) {
                              print(state.error.toString());
                            }
                          },
                          builder: (context, state) {
                            if (state is TransactionLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return CustomButton(
                              title: 'Submit',
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Jika validasi berhasil, lakukan sesuatu
                                  if (typeIdController.text.isNotEmpty) {
                                    context.read<TransactionCubit>().postTrx({
                                      "amount": amountlController.text,
                                      "type_id": typeIdController.text,
                                      "category_id": categoryIdController.text,
                                      "note": notesIdController.text,
                                    });
                                  }
                                }
                              },
                            );
                          },
                        )
                      ],
                    ),
                  );
                }
                return const Text("Error fetch data, pleaserefresh page");
              },
            ),
          ],
        ),
      );
    }

    Widget modalAddNote() {
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

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: appBarSection()),
      body: Form(
          key: _formKey,
          child: Stack(
            children: [
              ListView(
                children: [
                  nominalSection(),
                  balanceInfoSection(),
                  additionalSections(),
                ],
              ),
              if (showNotes) modalAddNote()
            ],
          )),
    );
  }
}

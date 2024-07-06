import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class CustomDropdownItem extends StatefulWidget {
  final String title;
  final TextEditingController selectItem;

  const CustomDropdownItem(
      {super.key, required this.title, required this.selectItem});

  @override
  State<CustomDropdownItem> createState() => _CustomDropdownItemState();
}

class _CustomDropdownItemState extends State<CustomDropdownItem> {
  List<String> itemsList = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String selectedItem = "";

  @override
  void initState() {
    selectedItem = itemsList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 14),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: double.infinity, // Set lebar dropdown
            height: 60, // Set tinggi dropdown
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: kGreyColor,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(selectedItem),
              items: itemsList.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value!;
                  widget.selectItem.text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

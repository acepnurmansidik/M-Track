import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class CustomDropdownItem extends StatefulWidget {
  final String title;
  final TextEditingController selectItem;
  final List<dynamic> items;
  final Function(int) onChange;

  CustomDropdownItem({
    super.key,
    required this.title,
    required this.selectItem,
    required this.items,
    required this.onChange,
  });

  @override
  State<CustomDropdownItem> createState() => _CustomDropdownItemState();
}

class _CustomDropdownItemState extends State<CustomDropdownItem> {
  String selectedItemName = "";

  @override
  void initState() {
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
              hint: Text(selectedItemName),
              items: widget.items.asMap().entries.map((el) {
                return DropdownMenuItem(
                  value: {
                    'id': el.value.id,
                    'name': el.value.name,
                    "child_index": el.value.items != null ? el.key : -1,
                  },
                  child: Text('${el.value.name}'),
                );
              }).toList(),
              onChanged: (value) {
                widget.onChange(value?["child_index"]);
                setState(() {
                  selectedItemName = value?["name"];
                  widget.selectItem.text = value?["id"];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

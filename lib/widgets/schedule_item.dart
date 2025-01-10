import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class ScheduleItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String date;

  const ScheduleItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: kRedColor,
              shape: BoxShape.circle,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: AnimatedContainer(
              height: isExpand == true ? 150 : 65,
              width: MediaQuery.of(context).size.width / 1.3,
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semibold,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: blackTextStyle,
                      ),
                    ],
                  ),
                  Text(
                    widget.date,
                    style: greyTextStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

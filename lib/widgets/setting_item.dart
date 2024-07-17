import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData iconMark;
  final bool isActive;
  final Function() onPressed;
  const SettingItem({
    super.key,
    required this.title,
    required this.iconMark,
    this.isActive = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: kWhiteColor),
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Icon(
              iconMark as IconData?,
              color: isActive ? kBlackColor : kGreyColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: isActive
                  ? blackTextStyle.copyWith(fontSize: 16, fontWeight: semibold)
                  : greyTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: isActive ? kBlackColor : kGreyColor,
            )
          ],
        ),
      ),
    );
  }
}

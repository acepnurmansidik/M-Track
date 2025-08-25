// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  bool isShowNotif;
  NotificationItem({super.key, required this.isShowNotif});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Image.asset('assets/notif.png'),
        ),
        isShowNotif
            ? Container(
                height: 11,
                width: 11,
                margin: const EdgeInsets.only(top: 5, left: 20),
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red[400],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

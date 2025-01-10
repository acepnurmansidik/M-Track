import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/schedule_item.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 20, right: 20),
            decoration: BoxDecoration(
              color: kPrimaryV2Color,
              shape: BoxShape.circle,
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(kWhiteColor, BlendMode.srcIn),
                  image: const AssetImage('assets/plus.png'),
                ),
              ),
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            SizedBox(
              child: Column(
                children: [
                  ScheduleItem(
                    title: "Lari pagi",
                    subtitle: "keliling gasibu",
                    date: "06:00",
                  ),
                  ScheduleItem(
                    title: "Sarapan",
                    subtitle: "sarapan",
                    date: "06:00",
                  ),
                  ScheduleItem(
                    title: "Code",
                    subtitle: "bikin project sendiri",
                    date: "06:00",
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

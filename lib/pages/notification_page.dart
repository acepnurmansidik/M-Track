import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/notification_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          NotificationItem(
            sId: "1",
            title: "Pemasukan bulanan berhasil di tambahkan sebesar",
            titleHighlight: "14.000.000",
            timestamp: "2 Oct 2025",
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      surfaceTintColor: kWhiteColor,
      backgroundColor: kWhiteColor,
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.arrow_back, color: kBlackColor),
                ),
              ),
              Text(
                'Notifications',
                style: blackTextStyle.copyWith(fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "100",
                  style: whiteTextStyle.copyWith(
                      fontSize: 12, fontWeight: semibold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

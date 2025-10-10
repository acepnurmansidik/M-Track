// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:tracking/theme.dart';
import 'package:tracking/widgets/slide_edit_backgroud.dart';
import 'package:tracking/widgets/slide_remove_backgroud.dart';

class NotificationItem extends StatelessWidget {
  String sId;
  String title;
  String titleHighlight;
  String timestamp;

  NotificationItem({
    super.key,
    required this.sId,
    required this.title,
    required this.titleHighlight,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(sId),
      direction: DismissDirection.horizontal,
      background: const SlideEditBackgroud(),
      secondaryBackground: const SlideRemoveBackgroud(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Dragged to the left
          // return cancelBtn(true, sId);
          return;
        } else {
          // Dragged to the right
          // return cancelBtn(false);
        }
      },
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: kGreyColor.withOpacity(.5), width: .5),
            bottom: BorderSide.none,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kGreyColor.withOpacity(.5),
                  width: .5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      kPrimaryV2Color,
                      BlendMode.srcIn,
                    ),
                    image: const AssetImage('assets/entertaiment.png'),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text.rich(
                      TextSpan(
                        text: title,
                        children: [
                          TextSpan(
                            text: ' $titleHighlight',
                            style:
                                blackTextStyle.copyWith(fontWeight: semibold),
                          ),
                        ],
                      ),
                      style: blackTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    timestamp,
                    style: greyTextStyle.copyWith(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

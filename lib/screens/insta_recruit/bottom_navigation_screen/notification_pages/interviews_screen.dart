// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/interview_tile.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/message_tile.dart';

import '../../../../widgets/custom_cards/custom_common_card.dart';

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: AppBar(
              elevation: 0,
              backgroundColor: MyColors.white,
              title: CommonText(
                text: "Interviews",
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (c, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InterviewTile(),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 8),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: "Messages",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  SizedBox(height: 6),
                  CommonText(
                    text: "All message",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (c, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: MessageTile(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/interview_tile.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/message_tile.dart';

import '../../../../widgets/custom_cards/custom_common_card.dart';

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({Key? key}) : super(key: key);

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: MyColors.white,
          title: CommonText(
            text: tabIndex == 0 ? "Interviews" : "Interview Recordings",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: TabBar(
                          unselectedLabelColor: MyColors.tabClr,
                          labelColor: MyColors.blue,
                          indicatorColor: MyColors.blue,
                          onTap: (val) {
                            tabIndex = val;
                            setState(() {});
                          },
                          tabs: [
                            Tab(text: "Upcoming"),
                            Tab(text: "Previous"),
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              child: InterviewTile(),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 3 / 8),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              child: InterviewTile(isRecording: true),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 3 / 8),
                        ),
                      ),
                    ]))
                  ],
                ),
              ),
            ),
            // SizedBox(height: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0),
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
                          text: "All messages",
                          fontSize: 13,
                          fontColor: MyColors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: MessageTile(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

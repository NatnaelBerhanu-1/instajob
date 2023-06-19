// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: "History",
          leadingImage: MyImages.cancel4x,
          imageColor: MyColors.blue,
          height: 16,
          width: 16,
          leadingWidth: 40,
          // leadingImage: MyImages.,
        ),
      ),
      body: Column(
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
                        tabs: [
                          Tab(text: "AI Questions"),
                          Tab(text: "Notes"),
                        ]),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: MyColors.lightGrey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CommonText(
                                      text: "00:12",
                                      fontSize: 13,
                                      fontColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: CommonText(
                                        text: "Teressa William:",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(
                                      child: CommonText(
                                        text: "Hey, Hope you are doing well!",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: MyColors.lightGrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CommonText(
                                                text: "Note 1",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 0,
                                              child: CommonText(
                                                text: "00:12",
                                                fontSize: 13,
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        CommonText(
                                          text:
                                              "Lorem Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae ",
                                          fontSize: 13,
                                          fontColor: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

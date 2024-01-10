// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

overviewBottomSheet(context) {
  return showModalBottomSheet(
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyColors.lightgrey,
                        ),
                        child: SizedBox(),
                      ),
                    ),
                    CommonText(
                      text: "Overview",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
                                            text:
                                                "Hey, Hope you are doing well!",
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
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (c, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: MyColors.lightGrey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 0,
                                                        child: CommonText(
                                                          text: "00:12",
                                                          fontSize: 13,
                                                          fontColor:
                                                              Colors.grey,
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
                              IconTextField(
                                controller: TextEditingController(),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                // color: MyColors.lightGrey,
                                // prefixIcon: null,
                                color: MyColors.lightGrey,
                                borderRadius: 25,
                                hint: "Write message here..",
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 2.0),
                                    child: Container(
                                      // alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: MyColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13.5, horizontal: 18),
                                        child: CommonText(
                                          text: "Send",
                                          fontColor: MyColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]))
                    ],
                  ),
                ),
              ),
            ],
          ));
}

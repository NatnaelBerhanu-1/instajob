// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class TranscriptionScreen extends StatefulWidget {
  const TranscriptionScreen({Key? key}) : super(key: key);

  @override
  State<TranscriptionScreen> createState() => _TranscriptionScreenState();
}

class _TranscriptionScreenState extends State<TranscriptionScreen> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: tabIndex == 0 ? "Transcription" : "Summary",
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
                        onTap: (val) {
                          tabIndex = val;
                          setState(() {});
                        },
                        tabs: [
                          Tab(text: "Transcription"),
                          Tab(text: "AI Summary"),
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
/*SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.06,
                        left: 0,
                        right: 0,
                        child: CustomCommonCard(
                          // height: 200,
                          borderRadius: BorderRadius.circular(15),
                          borderColor: MyColors.blue,
                          bgColor: MyColors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.06),
                              CommonText(
                                text: "Tim Barbeque",
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                text: "Product Designer",
                                fontColor: MyColors.grey,
                                fontSize: 12,
                              ),
                              SizedBox(height: 15),
                              Divider(
                                color: MyColors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 8, right: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                            text: "Location",
                                            fontColor: MyColors.grey,
                                            fontSize: 12,
                                          ),
                                          SizedBox(height: 5),
                                          CommonText(
                                            text: "Ann Arnor",
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                            text: "Work experience",
                                            fontColor: MyColors.grey,
                                            fontSize: 12,
                                          ),
                                          SizedBox(height: 5),
                                          CommonText(
                                            text: "2+ years",
                                            // fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                            text: "Applied on",
                                            fontColor: MyColors.grey,
                                            fontSize: 12,
                                          ),
                                          SizedBox(height: 5),
                                          CommonText(
                                            text: "21st February",
                                            // fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 8, right: 8, bottom: 20),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color: Colors.blue),
                                      ),
                                      child: ListTile(
                                        dense: true,
                                        visualDensity:
                                            VisualDensity(vertical: -2),
                                        title: Row(
                                          children: [
                                            Spacer(),
                                            Icon(
                                              Icons.file_present_sharp,
                                              color: MyColors.blue,
                                              size: 16,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Resume-2020.pdf",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MyColors.black,
                                                overflow: TextOverflow.clip,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: MediaQuery.of(context).size.height * 0.175,
                        child: CircleAvatar(
                          radius: 40,
                          child: ImageButton(
                            image: MyImages.user,
                            color: MyColors.white,
                          ),
                        ),
                      )
                      // CachedNetworkImage(
                      //   imageUrl: MyImages.user,
                      // ),
                    ],
                  ),
                ),*/

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_position_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class SearchJobTile extends StatelessWidget {
  const SearchJobTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(context, JobPositionScreen());
      },
      child: Container(
          decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColors.grey.withOpacity(.30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.10),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(2, 3))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(MyImages.suitcase),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: "Candidate",
                              fontSize: 14,
                              fontColor: MyColors.black,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 5),
                            CommonText(
                              text: "2714 wasterrn ave. ann arbo MI",
                              fontSize: 12,
                              fontColor: MyColors.grey,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CustomCommonCard(
                          bgColor: MyColors.lightBlue.withOpacity(.20),
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CommonText(
                              text: "Full Time",
                              fontSize: 12,
                              fontColor: MyColors.blue,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomCommonCard(
                          bgColor: Colors.cyan.withOpacity(.20),
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CommonText(
                              text: "60k+",
                              fontSize: 12,
                              fontColor: Colors.cyan,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomCommonCard(
                          bgColor: Colors.purpleAccent.withOpacity(.30),
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CommonText(
                              text: "Senior Level",
                              fontSize: 12,
                              fontColor: Colors.purpleAccent,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Spacer(),
                ImageButton(
                  image: MyImages.fav,
                  color: MyColors.grey,
                  padding: EdgeInsets.zero,
                  height: 20,
                  width: 20,
                ),
                SizedBox(width: 15),
              ],
            ),
          )),
    );
  }
}

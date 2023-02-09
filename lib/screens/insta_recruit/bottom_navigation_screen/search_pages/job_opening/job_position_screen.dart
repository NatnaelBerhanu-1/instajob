// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/edit_listing_screen.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_expantion_tile.dart';

import '../../../../../utils/my_colors.dart';
import 'view_candidate.dart';

class JobPositionScreen extends StatefulWidget {
  const JobPositionScreen({Key? key}) : super(key: key);

  @override
  State<JobPositionScreen> createState() => _JobPositionScreenState();
}

class _JobPositionScreenState extends State<JobPositionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Image.asset(MyImages.jobUser, fit: BoxFit.cover)),
        Positioned(
          top: 30,
          child: ImageButton(
            image: MyImages.backArrow,
            height: 40,
            width: 40,
          ),
        ),
        /* Positioned(
          top: 30,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.share, color: MyColors.white),
            onPressed: () {},
          ),
        ),*/
        Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height * 0.36,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17),
                            topRight: Radius.circular(17)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: "Job Position",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ImageButton(
                                        image: MyImages.bag,
                                        padding: EdgeInsets.zero),
                                    SizedBox(width: 5),
                                    CommonText(
                                      text: "Job Position",
                                      fontColor: MyColors.blue,
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                CommonText(
                                  text: "Job Details",
                                  fontSize: 15,
                                ),
                                SizedBox(height: 15),
                                CommonText(
                                  text:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor volutpat felis pretium volutpat. Proin et luctus lectus, lobortis molestie felis. Suspendisse lobortis, diam eu aliquam molestie, erat massa viverra dolor, quis pellentesque erat velit ac felis. Aenean tincidunt",
                                  fontSize: 13,
                                  fontColor: MyColors.grey,
                                ),
                                SizedBox(height: 15),
                                buildRequirementTile(),
                                buildResponsibilityTile(),
                                buildTopSkillsTile(),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomButton(
                                      title: "Edit Listing",
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: EditListing());
                                      },
                                    )),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: CustomButton(
                                      title: "View Candidates",
                                      onTap: () {
                                        push(
                                            context: context,
                                            screen: ViewCandidates());
                                      },
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )),
        /* Positioned(
          top: MediaQuery.of(context).size.height * 0.334,
          right: 20,
          child: CustomCommonCard(
            bgColor: MyColors.blue,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite, color: MyColors.white),
            ),
          ),
        ),*/
      ],
    ));
  }
}

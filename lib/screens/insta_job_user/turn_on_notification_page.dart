// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';

class TurnOnNotification extends StatelessWidget {
  const TurnOnNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(MyImages.notifyBg),
            Positioned(
              right: 15,
              top: 45,
              child: GestureDetector(
                onTap: () {
                  AppRoutes.pushAndRemoveUntil(context, BottomNavScreen());
                },
                child: CommonText(
                  text: "Skip For Now",
                  fontColor: MyColors.white,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.11,
              left: MediaQuery.of(context).size.width / 3,
              child: Image.asset(
                MyImages.instaLogo_,
                color: MyColors.white,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.166,
              left: MediaQuery.of(context).size.width / 2.8,
              child: CommonText(
                text: "Employ instantly",
                // fontSize: 13,
                fontColor: MyColors.white,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              left: MediaQuery.of(context).size.width * 0.13,
              child: CustomCommonCard(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "InstaJob",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontColor: MyColors.blue,
                      ),
                      SizedBox(height: 7),
                      CommonText(
                        text: "You have a message from a Job Interview",
                        fontSize: 13,
                        fontColor: MyColors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: 20),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Turn On",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: "Notification",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 0, child: ImageButton(image: MyImages.verified)),
                    Expanded(
                      child: CommonText(
                        text: "Resource to help jobs",
                        fontColor: MyColors.grey,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                divider(),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        flex: 0, child: ImageButton(image: MyImages.verified)),
                    Expanded(
                      child: CommonText(
                        text: "Apply to jobs in just a touch of button",
                        fontColor: MyColors.grey,
                      ),
                    ),
                  ],
                ),
                divider(),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        flex: 0, child: ImageButton(image: MyImages.verified)),
                    Expanded(
                      child: CommonText(
                        text: "Tailor made services just for you",
                        fontColor: MyColors.grey,
                      ),
                    ),
                  ],
                ),
                divider(),
                SizedBox(height: 50),
                CustomIconButton(
                  title: "Turn On",
                  image: MyImages.arrowWhite,
                  onclick: () {
                    AppRoutes.pushAndRemoveUntil(context, BottomNavScreen());
                  },
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

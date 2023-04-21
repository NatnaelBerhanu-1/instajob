// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/save_card_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/user_tile/custom_job_boards_card.dart';

class JobBoardsScreen extends StatelessWidget {
  const JobBoardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 0,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageButton(
                        onTap: () {
                          AppRoutes.pop(context);
                        },
                        image: MyImages.backArrow,
                        padding: EdgeInsets.zero,
                        height: 40,
                        width: 40),
                    SizedBox(width: 30),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          MyImages.diamond,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 200,
                        ),
                        CommonText(
                          text: "Get access to over 500+",
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        CommonText(
                          text: "Job Boards",
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CustomJobBoardsCard(
                    image: MyImages.enterprise,
                    desc: MyColors.white,
                    color: MyColors.white,
                    onTap: () {
                      AppRoutes.push(
                          context, SaveCardScreen(isChoosePayment: true));
                    },
                  ),
                  SizedBox(height: 15),
                  CustomJobBoardsCard(
                    image: MyImages.business,
                  ),
                  SizedBox(height: 15),
                  CustomJobBoardsCard(
                    image: MyImages.business,
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    title: "Confirm",
                    onTap: () {
                      AppRoutes.push(
                          context, SaveCardScreen(isChoosePayment: true));
                    },
                  ),
                  SizedBox(height: 20),
                  CommonText(
                    text: "Will reoccur every month until cancelled",
                    fontSize: 12,
                    fontColor: MyColors.blue,
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}

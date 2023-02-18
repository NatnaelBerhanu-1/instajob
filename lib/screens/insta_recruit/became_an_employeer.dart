// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/screens/auth_screen/verify_code_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../widgets/custom_button/custom_btn.dart';

class BecameAnEmployer extends StatelessWidget {
  const BecameAnEmployer({Key? key}) : super(key: key);

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
                    Spacer(),
                    // ImageButton(
                    //     image: MyImages.backArrow, height: 30, width: 30),
                    // SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Became An Employer",
                          fontColor: MyColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        SizedBox(height: 20),
                        CommonText(
                          text: "add client information and Job details",
                          fontSize: 13,
                        ),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  IconTextField(
                    prefixIcon: ImageButton(image: MyImages.userFilled),
                    suffixIcon: ImageButton(image: MyImages.verified),
                    hint: "Company Name",
                  ),
                  SizedBox(height: 20),
                  IconTextField(
                    prefixIcon: ImageButton(image: MyImages.phone),
                    suffixIcon: SizedBox(),
                    hint: "9685568565",
                  ),
                  SizedBox(height: 20),
                  IconTextField(
                    prefixIcon: ImageButton(image: MyImages.internet),
                    suffixIcon: SizedBox(),
                    hint: "www.organize.com",
                  ),
                  SizedBox(height: 40),
                  uploadPhotoCard(),
                  SizedBox(height: 40),
                  CustomIconButton(
                    image: MyImages.arrowWhite,
                    title: "Next",
                    backgroundColor: MyColors.blue,
                    fontColor: MyColors.white,
                    borderColor: MyColors.blue,
                    iconColor: MyColors.blue,
                    onclick: () {
                      AppRoutes.push(context, VerifyCodeScreen());
                    },
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}

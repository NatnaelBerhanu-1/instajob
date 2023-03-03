// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class RateCallScreen extends StatelessWidget {
  const RateCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Rate Call",
              actions: ImageButton(
                image: MyImages.businessAndTrade,
                padding: EdgeInsets.only(left: 10, right: 20),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CommonText(
                    text: "Skip",
                    fontColor: MyColors.grey,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(MyImages.rateOutline),
                    Image.asset(MyImages.rateOutline),
                    Image.asset(MyImages.rateOutline),
                    Image.asset(MyImages.rateOutline),
                    Image.asset(MyImages.rateOutline),
                  ],
                ),
                SizedBox(height: 40),
                CustomTextField(
                  hint: "Message...",
                  maxLine: 10,
                ),
                SizedBox(height: 60),
                CustomButton(
                  title: "Leave Feedback",
                )
              ],
            ),
          ),
        ));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_acc_details.dart';

import '../widgets/custom_button/custom_img_button.dart';
import '../widgets/custom_cards/custom_job_boards_card.dart';
import '../widgets/custom_cards/custom_user_type_card.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, kToolbarHeight),
      //   child: CustomAppBar(
      //     title: "",
      //     leadingImage: MyImages.backArrow,
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: CustomCommonText(
                  text: "Welcome",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              ImageButton(
                image: MyImages.logo,
                padding: EdgeInsets.zero,
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              UserTypeCard(),
              SizedBox(height: 20),
              CustomAccDetails(
                img: MyImages.rate,
                title: "Feedbacks",
              ),
              SizedBox(height: 20),
              CustomJobBoardsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCommonText extends StatelessWidget {
  final String? text;
  final Color? txtClr;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomCommonText({
    Key? key,
    this.text,
    this.fontSize,
    this.fontWeight,
    this.txtClr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        color: txtClr ?? MyColors.black,
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}

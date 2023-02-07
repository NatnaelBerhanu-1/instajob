// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../widgets/custom_button/custom_btn.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImages.maskGroup), fit: BoxFit.fitWidth)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(MyImages.cancel)),
                  Image.asset(MyImages.completed),
                  SizedBox(height: 15),
                  CommonText(
                    text: "Congratulations",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Image.asset(MyImages.completedPana),
                  SizedBox(height: 30),
                  Spacer(),
                  CustomButton(
                    title: "Confirm",
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
          ),
        ));
  }
}

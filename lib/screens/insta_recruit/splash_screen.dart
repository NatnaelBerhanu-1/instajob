// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../widgets/custom_cards/custom_common_card.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.bg), fit: BoxFit.cover)),
            child: Center(
              child: Column(
                children: [
                  CommonText(
                    text: "Welcome",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  Image.asset(
                    MyImages.logo,
                    height: 200,
                    width: 200,
                  ),
                  Image.asset(MyImages.instaJobLogo),
                  Spacer(),
                  ImageButton(
                    image: MyImages.startArrow,
                    padding: EdgeInsets.zero,
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(height: 10),
                  CommonText(
                    text: "Get Started",
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    fontColor: MyColors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

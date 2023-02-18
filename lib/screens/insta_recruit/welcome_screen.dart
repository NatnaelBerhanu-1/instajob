// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/auth_screen/register_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../../utils/my_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                MyImages.logo,
                height: 200,
                width: 200,
              ),
            ),
            Center(child: Image.asset(MyImages.instaLogo_)),
            Center(
              child: CommonText(
                text: "Employee instantly",
              ),
            ),
            SizedBox(height: 50),
            CommonText(
              text: "Welcome",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            SizedBox(height: 5),
            CommonText(
              text:
                  "Login in to your existing account or register to make new\naccount.",
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            SizedBox(height: 30),
            CustomIconButton(
              image: MyImages.arrowWhite,
              title: "Sign in",
              onclick: () {
                AppRoutes.push(context, LoginScreen());
              },
            ),
            SizedBox(height: 20),
            CustomIconButton(
              image: MyImages.arrowWhite,
              title: "Register Now",
              backgroundColor: MyColors.white,
              fontColor: MyColors.black,
              borderColor: MyColors.blue,
              iconColor: MyColors.blue,
              onclick: () {
                AppRoutes.pushAndRemoveUntil(context, RegisterScreen());
              },
            ),
            SizedBox(height: 30),
            CustomDivider(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSocialButton(
                  image: MyImages.google,
                ),
                CustomSocialButton(
                  image: MyImages.twitter,
                ),
                CustomSocialButton(
                  image: MyImages.facebook,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
/*Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.bg), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomCommonText(
                    text: "Welcome",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    MyImages.logo,
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: UserTypeCard()),
                    Expanded(child: UserTypeCard()),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Image.asset(MyImages.instaLogo_),
                      CustomCommonText(
                        text: "Employee instantly",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_all_small_button.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        MyImages.bgCurve,
                        color: MyColors.grey.withOpacity(.10),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageButton(
                              image: MyImages.backArrow,
                              height: 30,
                              width: 30,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 50),
                            Column(
                              children: [
                                Image.asset(MyImages.instaLogo_),
                                CommonText(
                                  text: "Employee instantly",
                                  fontColor: MyColors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome,",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Enter your login details to access your account",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30),
                      IconTextField(
                        prefixIcon: ImageButton(image: MyImages.email),
                        suffixIcon: ImageButton(image: MyImages.verified),
                        hint: "alexies@mygmail.com",
                      ),
                      SizedBox(height: 15),
                      IconTextField(
                        prefixIcon: ImageButton(image: MyImages.lock),
                        suffixIcon: ImageButton(image: MyImages.visible),
                        hint: "password",
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyColors.blue,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomIconButton(
                        image: MyImages.arrowWhite,
                        title: "Sign In Now",
                        backgroundColor: MyColors.blue,
                        fontColor: MyColors.white,
                        borderColor: MyColors.blue,
                        iconColor: MyColors.white,
                      ),
                      SizedBox(height: 20),
                      CustomIconButton(
                        image: MyImages.arrowWhite,
                        title: "Register Now",
                        backgroundColor: MyColors.white,
                        fontColor: MyColors.black,
                        borderColor: MyColors.blue,
                        iconColor: MyColors.blue,
                      ),
                      SizedBox(height: 30),
                      CustomDivider(),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomSocialButton(image: MyImages.google),
                          CustomSocialButton(image: MyImages.twitter),
                          CustomSocialButton(image: MyImages.facebook),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/* Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImages.bgCurve))),
      ),*/

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:insta_job/screens/auth_screen/verify_code_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "",
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Forgot Password",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              SizedBox(height: 5),
              CommonText(
                text: "Enter your Email Address to Retrieve Password",
                fontWeight: FontWeight.w400,
                fontColor: MyColors.grey,
                fontSize: 13,
              ),
              SizedBox(height: 50),
              IconTextField(
                prefixIcon: ImageButton(image: MyImages.email),
                suffixIcon: ImageButton(image: MyImages.verified),
                hint: "alexis@mygmail.com",
              ),
              SizedBox(height: 40),
              Center(
                child: CommonText(
                  text: "I didn't receive the code",
                  fontWeight: FontWeight.w400,
                  fontColor: MyColors.grey,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  AppRoutes.push(context, VerifyCodeScreen());
                },
                child: Center(
                  child: CommonText(
                    text: "Resend",
                    fontWeight: FontWeight.w500,
                    fontColor: MyColors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 70),
              CustomIconButton(
                image: MyImages.arrowWhite,
                title: "Submit Now",
                backgroundColor: MyColors.blue,
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
                iconColor: MyColors.white,
                onclick: () {
                  AppRoutes.push(context, VerifyCodeScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

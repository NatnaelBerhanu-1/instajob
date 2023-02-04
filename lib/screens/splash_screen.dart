// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          title: "",
          leadingImage: MyImages.backArrow,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomCommonText(
                title: "Welcome",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              CustomTextField(
                hint: "fggg",
                suffixIcon: MyImages.visible,
                prefixIcon: MyImages.lock,
              ),
              CustomSocialButton(
                onTap: () {
                  buildDialog(context, CustomDialog());
                },
              ),
              CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCommonText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomCommonText({
    Key? key,
    this.title,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      style: TextStyle(
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}

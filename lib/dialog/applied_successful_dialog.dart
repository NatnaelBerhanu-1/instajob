// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../utils/my_images.dart';

class AppliedSuccessDialog extends StatelessWidget {
  const AppliedSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(MyImages.resume),
            SizedBox(height: 20),
            CommonText(
              text: "Job Successfully Applied",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            CustomButton(title: "Thanks!"),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_button/custom_img_button.dart';

class TellUsAboutYSlfPage extends StatelessWidget {
  final VoidCallback? onTap;

  const TellUsAboutYSlfPage({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ImageButton(
              onTap: () {
                Navigator.pop(context);
              },
              image: MyImages.arrowBlueLeft,
              padding: EdgeInsets.zero,
              height: 17,
              width: 17,
            ),
          ),
          SizedBox(height: 15),
          CommonText(
            text: "Tell Us",
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
          SizedBox(height: 5),
          CommonText(
            text: "About",
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
          SizedBox(height: 5),
          CommonText(
            text: "Yourself",
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
          SizedBox(height: 30),
          CustomTextField(
            hint: "Message...",
            maxLine: 10,
          ),
          SizedBox(height: 100),
          // Spacer(),
          CustomIconButton(
            onclick: onTap,
            title: "Continue",
            backgroundColor: MyColors.blue,
            borderColor: MyColors.blue,
            image: MyImages.arrowWhite,
          ),
        ],
      ),
    );
  }
}

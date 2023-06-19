// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class CustomTemplateCard extends StatelessWidget {
  final String? image;
  final String? label;
  final String? label2;
  const CustomTemplateCard({Key? key, this.image, this.label, this.label2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: MyColors.blue),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              MyImages.automateMsg,
              height: 30,
              width: 30,
            ),
          ),
        ),
        SizedBox(height: 5),
        CommonText(
          text: label,
          fontColor: MyColors.grey,
          fontSize: 14,
        ),
        CommonText(
          text: label2,
          fontColor: MyColors.grey,
          fontSize: 14,
        ),
      ],
    );
  }
}

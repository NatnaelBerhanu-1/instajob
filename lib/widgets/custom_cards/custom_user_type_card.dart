import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/splash_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_img_button.dart';

import '../../utils/my_images.dart';

class UserTypeCard extends StatelessWidget {
  const UserTypeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColors.white,
              boxShadow: [blueBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 25, left: 25, bottom: 10),
              child: Column(
                children: [
                  CustomCommonText(
                    text: "Recruiters",
                    txtClr: MyColors.blue,
                    fontSize: 19,
                  ),
                  const SizedBox(height: 5),
                  ImageButton(
                    image: MyImages.nextArrow,
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.white,
                boxShadow: [boxShadow],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ImageButton(
                  image: MyImages.businessAndTrade,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

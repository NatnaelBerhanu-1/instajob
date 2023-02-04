import 'package:flutter/material.dart';
import 'package:insta_job/screens/splash_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_img_button.dart';

class CustomAccDetails extends StatelessWidget {
  final String? img;
  final String? title;
  const CustomAccDetails({Key? key, this.img, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            ImageButton(
              image: img,
            ),
            CustomCommonText(
              text: title,
              txtClr: MyColors.grey,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}

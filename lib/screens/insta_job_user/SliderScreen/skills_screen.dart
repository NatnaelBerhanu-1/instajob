// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/skill_tile.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size(double.infinity, kToolbarHeight),
        //     child: CustomAppBar(
        //       title: "",
        //       leadingImage: MyImages.arrowBlueLeft,
        //       height: 15,
        //       width: 15,
        //     )),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ImageButton(
                  onTap: () {},
                  image: MyImages.arrowBlueLeft,
                  padding: EdgeInsets.zero,
                  height: 17,
                  width: 17,
                ),
                SizedBox(width: 15),
                CommonText(
                  text: "Skills",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ],
            ),
            SizedBox(height: 15),
            Center(
                child: Image.asset(
              MyImages.resumeImg,
              height: 200,
              width: 200,
            )),
            SizedBox(height: 15),
            CustomTextField(
              hint: "Search Skills",
              suffixIcon: Icon(
                Icons.search,
                size: 25,
                color: MyColors.blue,
              ),
            ),
            SizedBox(height: 15),
            CommonText(
              text: "Add Skills",
              fontWeight: FontWeight.w500,
              fontColor: MyColors.grey,
            ),
            SizedBox(height: 15),
            SkillsTile(
              title: "Photoshop",
            ),
            SkillsTile(
              title: "HTML 5",
            ),
            SkillsTile(
              title: "Photoshop",
              icon: Icons.remove,
              color: MyColors.red,
            ),
            SizedBox(height: 15),
            CustomDivider(
              title: "Added",
              color: MyColors.black,
            ),
            GridView.builder(
              itemCount: 7,
              shrinkWrap: true,
              itemBuilder: (i, c) => AddSkillTile(
                title: "Photoshop",
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 15 / 5),
            ),
            CustomButton(
              title: "Skip",
              bgColor: MyColors.white,
              fontColor: MyColors.black,
            ),
            CustomIconButton(
              title: "Continue",
              backgroundColor: MyColors.blue,
              borderColor: MyColors.blue,
              image: MyImages.arrowWhite,
              // onclick: onContinueTap,
            ),
          ],
        ),
      ),
    ));
  }
}

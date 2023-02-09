// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Feedback",
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                IconTextField(
                  hint: "Message....",
                  maxLine: 10,
                ),
                SizedBox(height: 40),
                CustomIconButton(
                  image: MyImages.arrowWhite,
                  title: "Leave Feedback",
                  backgroundColor: MyColors.blue,
                  fontColor: MyColors.white,
                  iconColor: MyColors.blue,
                ),
              ],
            ),
          ),
        ));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class AutomateMsgScreen extends StatefulWidget {
  const AutomateMsgScreen({Key? key}) : super(key: key);

  @override
  State<AutomateMsgScreen> createState() => _AutomateMsgScreenState();
}

class _AutomateMsgScreenState extends State<AutomateMsgScreen> {
  TextEditingController applicationReceivedSubject = TextEditingController();
  TextEditingController applicationReceivedContent = TextEditingController();
  TextEditingController disqualifiedReviewSubject = TextEditingController();
  TextEditingController disqualifiedReviewContent = TextEditingController();
  TextEditingController shortlistedReviewSubject = TextEditingController();
  TextEditingController shortlistedReviewContent = TextEditingController();

  bool isEnable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 0,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageButton(
                        onTap: () {
                          AppRoutes.pop(context);
                        },
                        image: MyImages.backArrow,
                        padding: EdgeInsets.zero,
                        height: 40,
                        width: 40),
                    SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Automate Message",
                          fontColor: MyColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        SizedBox(height: 20),
                        CommonText(
                          text: "Automate Message for All Interaction",
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CommonText(
                    text: "Application Received",
                    fontSize: 16,
                  ),
                  SizedBox(height: 10),
                  CommonText(
                    text: "Automated reply sent when candidate apply",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                  SizedBox(height: 10),
                  CommonText(
                    text: "Ask screening questions to speed up process",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: applicationReceivedSubject,
                    label: "Subject",
                    hint: "Your application at [Company Name]",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: applicationReceivedContent,
                    hint: "",
                    label: "Content",
                    maxLine: 5,
                  ),
                  SizedBox(height: 20),
                  CommonText(
                    text:
                        "To insert dynamic information,you can use [firstName],[lastName],[companyName] or [jobTitle]",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                  SizedBox(height: 25),
                  CommonText(
                    text: "Disqualified after review",
                    fontSize: 16,
                  ),
                  SizedBox(height: 10),
                  CommonText(
                    text:
                        "This will be sent the morning after rejecting a candidate",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: disqualifiedReviewSubject,
                    label: "Subject",
                    hint: "Your application at [Company Name]",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: disqualifiedReviewContent,
                    hint: "",
                    label: "Content",
                    maxLine: 5,
                  ),
                  SizedBox(height: 20),
                  CommonText(
                    text:
                        "To insert dynamic information,you can use [firstName],[lastName],[companyName] or [jobTitle]",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                  SizedBox(height: 25),
                  CommonText(
                    text: "Shortlisted after review",
                    fontSize: 16,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: shortlistedReviewSubject,
                    label: "Subject",
                    hint: "Your application at [Company Name]",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: shortlistedReviewContent,
                    hint: "",
                    label: "Content",
                    maxLine: 5,
                  ),
                  SizedBox(height: 20),
                  CommonText(
                    text:
                        "To insert dynamic information,you can use [firstName],[lastName],[companyName] or [jobTitle]",
                    fontSize: 13,
                    fontColor: MyColors.grey,
                  ),
                  SizedBox(height: 25),
                  CustomIconButton(
                    image: isEnable ? MyImages.arrowWhite : MyImages.cancel2x,
                    iconColor: isEnable ? MyColors.white : MyColors.blue,
                    title: isEnable ? "Enable" : "Disable",
                    backgroundColor: isEnable ? MyColors.blue : MyColors.white,
                    fontColor: isEnable ? MyColors.white : MyColors.blue,
                    borderColor: MyColors.blue,
                    onclick: () {
                      isEnable = !isEnable;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/confirm_details_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../utils/app_routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import 'cover_letter_screen.dart';

class ConfirmDetailsScreen extends StatefulWidget {
  const ConfirmDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmDetailsScreen> createState() => _ConfirmDetailsScreenState();
}

class _ConfirmDetailsScreenState extends State<ConfirmDetailsScreen> {
  TextEditingController name =
      TextEditingController(text: Global.userModel?.name);
  TextEditingController phoneNumber = TextEditingController(text: "9876542980");
  TextEditingController previousWork = TextEditingController(
      text: "work with software company for 2 years, Freelancing on fiverr");
  TextEditingController passion = TextEditingController();
  TextEditingController skills = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "Confirm Details",
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "We have extracted information from your resume to help us with will help our AI to give personalized Cover Letter"),
                  )
                ],
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: name, lblColor: MyColors.black,
                label: "Your Name",

                suffixIcon: buildSuffix(),
                // hint: "${Global.userModel?.name}",
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: phoneNumber, lblColor: MyColors.black,
                label: "Phone Number",
                suffixIcon: buildSuffix(),
                // hint: "9729864329",
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: skills,
                label: "Your top 5 skills",
                lblColor: MyColors.black,
                suffixIcon: buildSuffix(),
                hint: "",
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: "Previous Work",
                lblColor: MyColors.black,
                controller: previousWork,
                suffixIcon: buildSuffix(),
                // heading: "Previous Work",
                hint: "",
                maxLine: 2,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: passion,
                label: "Your Passion",
                hint: "",
                suffixIcon: buildSuffix(),
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Confirm all details",
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
                onTap: () {
                  AppRoutes.push(context, CoverLetterScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

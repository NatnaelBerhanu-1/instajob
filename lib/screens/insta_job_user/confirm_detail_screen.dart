// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/confirm_details_card.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

class ConfirmDetailsScreen extends StatelessWidget {
  const ConfirmDetailsScreen({Key? key}) : super(key: key);

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
              ConfirmDetailTile(
                  heading: "Your Name",
                  child: CommonText(
                    text: "Karean Ritchard",
                  )),
              SizedBox(height: 20),
              ConfirmDetailTile(
                  heading: "Phone Number",
                  child: CommonText(
                    text: "8123-3219-120314",
                  )),
              SizedBox(height: 20),
              ConfirmDetailTile(
                  heading: "Your top 5 skills",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "Photoshop",
                        fontSize: 14,
                      ),
                      CommonText(
                        text: "Adobe XD",
                        fontSize: 14,
                      ),
                      CommonText(
                        text: "Uxui Designing",
                        fontSize: 14,
                      ),
                      CommonText(
                        text: "Logo Designing",
                        fontSize: 14,
                      ),
                      CommonText(
                        text: "Flayer Design",
                        fontSize: 14,
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              ConfirmDetailTile(
                  heading: "Previous Work",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonText(
                          text:
                              'work with software company for 2 years, Freelancing on fiverr',
                          fontSize: 14.2,
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 20),
              ConfirmDetailTile(
                  heading: "Your Passion",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonText(
                          text: '......',
                          fontSize: 14.2,
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 30),
              CustomButton(
                title: "Confirm all details",
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

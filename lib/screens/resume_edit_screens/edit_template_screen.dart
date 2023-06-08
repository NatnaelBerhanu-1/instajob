// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_job_user/SliderScreen/Slider_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_template_card.dart';

class EditTemplateScreen extends StatelessWidget {
  const EditTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // physics: ClampingScrollPhysics(),
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            )),
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Templates",
                        )),
                        // Spacer(),
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Colors",
                        )),
                        // Spacer(),
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Fonts",
                        )),
                        // Spacer(),
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Photo",
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      title: "Edit Content",
                      bgColor: MyColors.white,
                      borderColor: MyColors.blue,
                      fontColor: MyColors.blue,
                      onTap: () {
                        AppRoutes.push(context, SliderScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.blue,
            ),
            child: Column(
              children: [
                Text("Change Color"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:insta_job/dialog/applied_successful_dialog.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

class CoverLetterScreen extends StatelessWidget {
  final ResumeModel resumeModel;
  const CoverLetterScreen({Key? key, required this.resumeModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "Cover Letter",
            actions: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.copy,
                  color: MyColors.blue,
                )),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCommonCard(
                borderColor: MyColors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Dear Hiring Manager\n"),
                      Text("${resumeModel.previousWork}\n"),
                      Text("Thank you for your consideration\n"),
                      Text("Sincerely\n"),
                      Text("${resumeModel.yourName}"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Re-Generate",
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Confirm & Apply",
                bgColor: MyColors.white,
                fontColor: MyColors.blue,
                borderColor: MyColors.blue,
                onTap: () {
                  buildDialog(context, AppliedSuccessDialog());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

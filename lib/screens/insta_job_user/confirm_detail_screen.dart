// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/cover_letter_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/screens/insta_job_user/cover_letter_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/confirm_details_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

class ConfirmDetailsScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  const ConfirmDetailsScreen({Key? key, this.jobPosModel}) : super(key: key);

  @override
  State<ConfirmDetailsScreen> createState() => _ConfirmDetailsScreenState();
}

class _ConfirmDetailsScreenState extends State<ConfirmDetailsScreen> {
  TextEditingController name =
      TextEditingController(text: Global.userModel?.name);
  TextEditingController phoneNumber =
      TextEditingController(text: "${Global.userModel?.phoneNumber}");
  TextEditingController previousWork = TextEditingController(
      text: "Work with software company for 2 years, Freelancing on fiverr");
  TextEditingController passion = TextEditingController(
      text:
          "I am capable and consistent problem solver skilled at prioritizing and managing projects with proficiency");
  TextEditingController skills =
      TextEditingController(text: "Photoshop\nAdobe XD\nUI/UX designing");
  String nameVal = "";
  String phone = "";
  String passionVal = "";
  String skillVal = "";
  String pWork = "";

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
          child:
              BlocBuilder<ResumeBloc, ResumeState>(builder: (context, state) {
            var resumeData = context.read<ResumeBloc>();
            return Column(
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
                  suffixIcon: buildSuffix(confirm: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                  hint: "",
                  onChanged: (val) {
                    nameVal = val;
                    setState(() {});
                  },

                  // hint: "${Global.userModel?.name}",
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: phoneNumber,
                  lblColor: MyColors.black,
                  label: "Phone Number",
                  maxLength: 10,
                  suffixIcon: buildSuffix(confirm: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                  keyboardType: TextInputType.number,
                  hint: "9729864329",
                  onChanged: (val) {
                    phone = val;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: skills,
                  label: "Your top 5 skills",
                  lblColor: MyColors.black,
                  suffixIcon: buildSuffix(confirm: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                  hint: "",
                  keyboardType: TextInputType.multiline,
                  onChanged: (val) {
                    skillVal = val;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "Previous Work",
                  lblColor: MyColors.black,
                  controller: previousWork,
                  suffixIcon: buildSuffix(confirm: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                  // heading: "Previous Work",
                  hint: "",
                  maxLine: 2,
                  onChanged: (val) {
                    pWork = val;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passion,
                  label: "Your Passion",
                  hint: "",
                  suffixIcon: buildSuffix(confirm: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                  onChanged: (val) {
                    passionVal = val;
                    setState(() {});
                  },
                ),
                SizedBox(height: 30),
                CustomButton(
                  title: "Confirm all details",
                  fontColor: MyColors.white,
                  borderColor: MyColors.blue,
                  onTap: () {
                    // upload_resume
                    CoverLetterModel coverLetterModel = CoverLetterModel(
                        phoneNumber:
                            int.parse(phone.isEmpty ? phoneNumber.text : phone),
                        yourName: nameVal.isEmpty ? name.text : nameVal,
                        previousWork: pWork.isEmpty ? previousWork.text : pWork,
                        yourPassion:
                            passionVal.isEmpty ? passion.text : passionVal,
                        yourTop5Skills:
                            skillVal.isEmpty ? skills.text : skillVal);
                    resumeData.add(AddResumeEvent(coverLetterModel));
                    AppRoutes.push(
                        context,
                        CoverLetterScreen(
                            coverLetterModel: coverLetterModel,
                            jobPosModel: widget.jobPosModel));
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

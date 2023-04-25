// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/screens/insta_job_user/cover_letter_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/confirm_details_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

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
  String nameVal = "";
  String phone = "";
  String passionVal = "";
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
                  suffixIcon: buildSuffix(),
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
                  suffixIcon: buildSuffix(),
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
                  suffixIcon: buildSuffix(),
                  hint: "",
                  onChanged: (val) {
                    // nameVal = val;
                    // setState(() {});
                  },
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
                  suffixIcon: buildSuffix(),
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
                    ResumeModel resumeModel = ResumeModel(
                        phoneNumber: int.parse(phoneNumber.text),
                        yourName: nameVal.isEmpty ? name.text : nameVal,
                        previousWork: pWork.isEmpty ? previousWork.text : pWork,
                        yourPassion:
                            passionVal.isEmpty ? passion.text : passionVal,
                        yourTop5Skills: "java");
                    resumeData.add(AddResumeEvent(resumeModel));
                    AppRoutes.push(
                        context, CoverLetterScreen(resumeModel: resumeModel));
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

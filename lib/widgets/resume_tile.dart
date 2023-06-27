// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class ResumeTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Educations? educations;
  final WorkExperiences? workExperiences;
  final bool isWorkExp;
  final int index;

  const ResumeTile(
      {Key? key,
      this.onTap,
      this.educations,
      this.workExperiences,
      this.isWorkExp = false,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCommonCard(
      borderRadius: BorderRadius.circular(10),
      borderColor: MyColors.lightgrey,
      boxShadow: normalBoxShadow,
      bgColor: MyColors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(9),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9), topRight: Radius.circular(9)),
            ),
            child: Row(
              children: [
                Text(
                  "${isWorkExp ? "Work Experience" : "Education"} $index",
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                BlocBuilder<ResumeBloc, ResumeState>(
                    builder: (context, snapshot) {
                  return ImageButton(
                    image: MyImages.cancel2x,
                    padding: EdgeInsets.zero,
                    height: 19,
                    color: MyColors.white,
                    onTap: onTap,
                    // onTap: () {
                    //   data.add(DeleteEducation(index));
                    // },
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: isWorkExp ? "Job Title:" : "Institute Name:",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp ? "Employee:" : "Field Of Study:",
                          fontSize: 14),
                      CommonText(text: "City:", fontSize: 14),
                      CommonText(text: "State:", fontSize: 14),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.jobTitle}"
                              : "${educations?.institutionName}",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.employer}"
                              : "${educations?.fieldOfStudy}",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.workCity}"
                              : "${educations?.educationCity}",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.workState}"
                              : "${educations?.educationState}",
                          fontSize: 14),
                      // CommonText(
                      //     text:
                      //         "${educations?.educationStartMonth} - ${educations?.educationStartYear}",
                      //     fontSize: 14),
                      // CommonText(
                      //     text:
                      //         "${educations?.educationEndMonth} - ${educations?.educationEndYear}",
                      //     fontSize: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

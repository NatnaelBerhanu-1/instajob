// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../bloc/global_cubit/global_cubit.dart';
import '../../../../../bloc/global_cubit/global_state.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_images.dart';

class AddJobPositionScreen extends StatefulWidget {
  final bool isUpdate;
  const AddJobPositionScreen({Key? key, this.isUpdate = false})
      : super(key: key);

  @override
  State<AddJobPositionScreen> createState() => _AddJobPositionScreenState();
}

class _AddJobPositionScreenState extends State<AddJobPositionScreen> {
  TextEditingController jobDetails = TextEditingController();
  TextEditingController requirements = TextEditingController();
  TextEditingController responsibility = TextEditingController();
  TextEditingController topSkills = TextEditingController();
  TextEditingController applicationReceivedSubject = TextEditingController();
  TextEditingController applicationReceivedContent = TextEditingController();
  TextEditingController disqualifiedReviewSubject = TextEditingController();
  TextEditingController disqualifiedReviewContent = TextEditingController();
  TextEditingController shortlistedReviewSubject = TextEditingController();
  TextEditingController shortlistedReviewContent = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.white,
          toolbarHeight: 53,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isUpdate ? "Edit Listing" : "Add Job Positions",
                  style: TextStyle(color: MyColors.black),
                ),
                SizedBox(height: 5),
                Text(
                  widget.isUpdate
                      ? "Update job details"
                      : "Add new details for new opening",
                  style: TextStyle(color: MyColors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          leading:
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, value) {
            return ImageButton(
              onTap: () {
                context
                    .read<GlobalCubit>()
                    .setSelectedScreen(false, screenName: BottomNavScreen());
                // Navigator.pop(context);
              },
              image: MyImages.backArrow,
            );
          }),
          actions: [
            widget.isUpdate
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 10),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: MyColors.lightRed)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Remove Listing",
                          style:
                              TextStyle(fontSize: 13, color: MyColors.lightRed),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
            child: ListView(
              children: [
                CustomTextField(
                  controller: jobDetails,
                  label: "Enter Job Details",
                  lblColor: MyColors.black,
                  hint: "Sed ut perspisious",
                  maxLine: 5,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: requirements,
                  label: "Enter Requirements",
                  lblColor: MyColors.black,
                  hint: "Sed ut perspisious",
                  maxLine: 5,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: responsibility,
                  label: "Enter Responsibility",
                  lblColor: MyColors.black,
                  hint: "",
                  maxLine: 5,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: topSkills,
                  label: "Enter Top Skills",
                  lblColor: MyColors.black,
                  hint: "",
                  maxLine: 5,
                ),
                SizedBox(height: 15),
                CommonText(
                  text: "Salaries",
                  fontSize: 14,
                ),
                SizedBox(height: 10),
                CustomCommonCard(
                  borderColor: MyColors.grey.withOpacity(.30),
                  borderRadius: BorderRadius.circular(7),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: "All Salaries",
                              fontSize: 12,
                              fontColor: MyColors.blue,
                            ),
                            ImageButton(
                              image: MyImages.verified,
                              padding: EdgeInsets.zero,
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        divider(color: MyColors.grey.withOpacity(.40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: "Custom Range",
                              fontSize: 14,
                              fontColor: MyColors.grey,
                            ),
                            CommonText(
                              text: "50k-1.2m",
                              fontSize: 14,
                              fontColor: MyColors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        RangeSlider(
                          values: RangeValues(10.0, 30.0),
                          onChanged: (val) {},
                          max: 80,
                          min: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CommonText(
                  text: "Area Distance",
                  fontSize: 14,
                ),
                SizedBox(height: 10),
                CustomCommonCard(
                  borderColor: MyColors.grey.withOpacity(.30),
                  borderRadius: BorderRadius.circular(7),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "With in 25 min",
                          fontSize: 12,
                          fontColor: MyColors.blue,
                        ),
                        SizedBox(height: 10),
                        divider(color: MyColors.grey.withOpacity(.40)),
                        SizedBox(height: 10),
                        Slider(
                          value: 10,
                          onChanged: (val) {},
                          max: 80,
                          min: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CommonText(
                  text: "Jobs Type",
                  fontSize: 14,
                ),
                SizedBox(height: 10),
                BlocBuilder<GlobalCubit, InitialState>(
                    builder: (context, state) {
                  var value = context.read<GlobalCubit>();
                  return Column(
                    children: [
                      CustomCommonCard(
                        borderColor: MyColors.grey.withOpacity(.30),
                        borderRadius: BorderRadius.circular(7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              jobTypeTile(
                                title: "Full Time",
                                index: value.jobTypeValue,
                                selectedIndex: "Full Time",
                                onTap: () {
                                  value.jobType("Full Time");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Part Time",
                                index: value.jobTypeValue,
                                selectedIndex: "Part Time",
                                onTap: () {
                                  value.jobType("Part Time");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Contact",
                                index: value.jobTypeValue,
                                selectedIndex: "Contact",
                                onTap: () {
                                  value.jobType("Contact");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),

                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Temporary",
                                index: value.jobTypeValue,
                                selectedIndex: "Temporary",
                                onTap: () {
                                  value.jobType("Temporary");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),
                              // divider(color: MyColors.grey.withOpacity(.40)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomCommonCard(
                        borderColor: MyColors.grey.withOpacity(.30),
                        borderRadius: BorderRadius.circular(7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              jobTypeTile(
                                title: "All Experience Level",
                                index: value.jobTypeValue,
                                selectedIndex: "All Experience Level",
                                onTap: () {
                                  value.jobType("All Experience Level");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Entry Level",
                                index: value.jobTypeValue,
                                selectedIndex: "Enter Level",
                                onTap: () {
                                  value.jobType("Enter Level");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Mid Level",
                                index: value.jobTypeValue,
                                selectedIndex: "Mid Level",
                                onTap: () {
                                  value.jobType("Mid Level");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),

                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Senior Level",
                                index: value.jobTypeValue,
                                selectedIndex: "Senior Level",
                                onTap: () {
                                  value.jobType("Senior Level");
                                  print("JOB VALUE ${value.jobTypeValue}");
                                },
                              ),
                              // divider(color: MyColors.grey.withOpacity(.40)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 30),
                uploadPhotoCard(context),
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
                BlocBuilder<JobPositionBloc, JobPosState>(
                    builder: (context, state) {
                  var jobPosition = context.read<JobPositionBloc>();
                  return CustomIconButton(
                    image: MyImages.arrowWhite,
                    title: widget.isUpdate
                        ? "Edit Job Position"
                        : "Post Job Position",
                    backgroundColor: MyColors.blue,
                    fontColor: MyColors.white,
                    borderColor: MyColors.blue,
                    onclick: () {},
                  );
                }),
              ],
            ),
          ),
        ));
  }
}

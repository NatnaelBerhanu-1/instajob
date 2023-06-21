// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/custom_resume_card.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

class EducationScreen extends StatefulWidget {
  final VoidCallback? onSkipTap;
  final PageController? pageController;
  const EducationScreen({Key? key, this.onSkipTap, this.pageController})
      : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  bool isStudyHere = false;

  TextEditingController instituteName = TextEditingController();
  TextEditingController fieldOfStudy = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController message = TextEditingController();

  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String startMonth = "";
  String endMonth = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size(double.infinity, kToolbarHeight),
        //     child: CustomAppBar(
        //       title: "",
        //       leadingImage: MyImages.arrowBlueLeft,
        //       height: 15,
        //       width: 15,
        //     )),
        body: Form(
      key: formKey,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 0,
                child: GestureDetector(
                  onTap: () {
                    widget.pageController?.jumpToPage(0);
                  },
                  child: Container(
                    color: MyColors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
                      child: Image.asset(
                        MyImages.arrowBlueLeft,
                        height: 17,
                        width: 17,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(width: 12),
              Expanded(
                flex: 0,
                child: CommonText(
                  text: "Education",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 0,
                child: TextButton.icon(
                    onPressed: () {
                      Educations educations = Educations(
                        institutionName: instituteName.text,
                        educationCity: city.text,
                        educationState: state.text,
                        fieldOfStudy: fieldOfStudy.text,
                        schoolHistory: isStudyHere ? 1 : 0,
                        educationStartMonth: startMonth,
                        educationEndMonth: isStudyHere ? "" : endMonth,
                        educationStartYear: startYear.toString(),
                        educationEndYear: isStudyHere ? "" : endYear.toString(),
                        educationCustomMessage: message.text,
                      );
                      context
                          .read<ResumeBloc>()
                          .add(AddEducationEvent(educations, isNew: true));
                      // instituteName.clear();
                    },
                    icon: Icon(Icons.add, size: 18),
                    label: CommonText(
                      text: "Add",
                      fontSize: 13,
                      fontColor: MyColors.blue,
                    )),
              ),
              Container(
                height: 20,
                width: 1,
                color: MyColors.grey,
              ),
              Expanded(
                flex: 0,
                child: TextButton.icon(
                    onPressed: () {},
                    icon:
                        Icon(Icons.delete, color: MyColors.lightRed, size: 18),
                    label: CommonText(
                      text: "Delete",
                      fontSize: 13,
                      fontColor: MyColors.lightRed,
                    )),
              ),
            ],
          ),
          SizedBox(height: 15),
          BlocBuilder<ResumeBloc, ResumeState>(builder: (context, snapshot) {
            var data = context.read<ResumeBloc>();
            return ListView.builder(
                shrinkWrap: true,
                itemCount: data.resumeModel.educations?.length,
                itemBuilder: (c, index) {
                  return CustomResumeCard(
                    inNew: true,
                    value: isStudyHere,
                    city: city,
                    fieldOfStudy: fieldOfStudy,
                    instituteName: instituteName,
                    state: state,
                    endYear: CustomTextField(
                      onPressed: isStudyHere
                          ? null
                          : () {
                              buildDialog(context, barrierDismissible: true,
                                  YearPickerDialog(
                                      onChange: (DateTime dateTime) {
                                Navigator.pop(context);
                                endYear = dateTime.year;
                                setState(() {});
                              }));
                            },
                      // validator: (val) => requiredValidationn(val!),
                      readOnly: true,
                      hint: isStudyHere
                          ? "Year"
                          : "${endYear == 0 ? "Year" : endYear}",
                      hintColor: isStudyHere
                          ? MyColors.grey
                          : endYear == 0
                              ? MyColors.grey
                              : MyColors.black,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                      ),
                    ),
                    startYear: CustomTextField(
                      readOnly: true,
                      hint: "${startYear == 0 ? "Year" : startYear}",
                      hintColor:
                          startYear == 0 ? MyColors.grey : MyColors.black,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                      ),
                      // validator: (val) => requiredValidationn(val!),
                      onPressed: () {
                        buildDialog(context, barrierDismissible: true,
                            YearPickerDialog(onChange: (DateTime dateTime) {
                          Navigator.pop(context);
                          startYear = dateTime.year;
                          setState(() {});
                        }));
                      },
                    ),
                    message: message,
                    onChange: (val) {
                      isStudyHere = !isStudyHere;
                      setState(() {});
                    },
                    onTap: () {
                      data.add(DeleteEducation(index));
                    },
                    startMonthDp: CustomDropdown(
                      list: monthList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                      value: startMonth.isNotEmpty ? startMonth : null,
                      onChanged: (val) {
                        startMonth = val;
                        setState(() {});
                      },
                      validator: (val) => requiredValidationn(val ?? ""),
                      hintText: Text(
                        "Month",
                        style: TextStyle(color: MyColors.grey),
                      ),
                    ),
                    endMonthDp: CustomDropdown(
                      list: isStudyHere
                          ? []
                          : monthList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                              .toList(),
                      value: endMonth.isNotEmpty ? endMonth : null,
                      onChanged: (val) {
                        endMonth = val;
                        setState(() {});
                      },
                      validator: (val) => requiredValidationn(val ?? ""),
                      hintText: Text(
                        "Month",
                        style: TextStyle(color: MyColors.grey),
                      ),
                    ),
                  );
                });
          }),
          SizedBox(height: 20),
          CustomResumeCard(
            value: isStudyHere,
            city: city,
            fieldOfStudy: fieldOfStudy,
            instituteName: instituteName,
            state: state,
            endYear: CustomTextField(
              onPressed: isStudyHere
                  ? null
                  : () {
                      buildDialog(context, barrierDismissible: true,
                          YearPickerDialog(onChange: (DateTime dateTime) {
                        Navigator.pop(context);
                        endYear = dateTime.year;
                        setState(() {});
                      }));
                    },
              // validator: (val) => requiredValidationn(val!),
              readOnly: true,
              hint: isStudyHere ? "Year" : "${endYear == 0 ? "Year" : endYear}",
              hintColor: isStudyHere
                  ? MyColors.grey
                  : endYear == 0
                      ? MyColors.grey
                      : MyColors.black,
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 30,
              ),
            ),
            startYear: CustomTextField(
              readOnly: true,
              hint: "${startYear == 0 ? "Year" : startYear}",
              hintColor: startYear == 0 ? MyColors.grey : MyColors.black,
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 30,
              ),
              // validator: (val) => requiredValidationn(val!),
              onPressed: () {
                buildDialog(context, barrierDismissible: true,
                    YearPickerDialog(onChange: (DateTime dateTime) {
                  Navigator.pop(context);
                  startYear = dateTime.year;
                  setState(() {});
                }));
              },
            ),
            message: message,
            onChange: (val) {
              isStudyHere = !isStudyHere;
              setState(() {});
            },
            startMonthDp: CustomDropdown(
              list: monthList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toString()),
                      ))
                  .toList(),
              value: startMonth.isNotEmpty ? startMonth : null,
              onChanged: (val) {
                startMonth = val;
                setState(() {});
              },
              validator: (val) => requiredValidationn(val ?? ""),
              hintText: Text(
                "Month",
                style: TextStyle(color: MyColors.grey),
              ),
            ),
            endMonthDp: CustomDropdown(
              list: isStudyHere
                  ? []
                  : monthList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
              value: endMonth.isNotEmpty ? endMonth : null,
              onChanged: (val) {
                endMonth = val;
                setState(() {});
              },
              validator: (val) => requiredValidationn(val ?? ""),
              hintText: Text(
                "Month",
                style: TextStyle(color: MyColors.grey),
              ),
            ),
          ),
          // SizedBox(height: 10),
          // CustomCommonCard(
          //   borderRadius: BorderRadius.circular(10),
          //   borderColor: MyColors.lightgrey,
          //   // boxShadow: normalBoxShadow,
          //   bgColor: MyColors.white,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Row(
          //                 children: [
          //                   Text("Institute Name:"),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         ImageButton(
          //           onTap: () {},
          //           image: MyImages.delete,
          //           padding: EdgeInsets.zero,
          //           height: 15,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 15),
          // CustomTextField(
          //   controller: message,
          //   hint: "Message...",
          // ),
          CustomButton(
            title: "Skip",
            bgColor: MyColors.white,
            fontColor: MyColors.black,
            onTap: () {
              widget.pageController?.jumpToPage(2);
            },
          ),
          BlocBuilder<ResumeBloc, ResumeState>(builder: (context, rState) {
            return CustomIconButton(
              title: "Continue",
              backgroundColor: MyColors.blue,
              borderColor: MyColors.blue,
              image: MyImages.arrowWhite,
              onclick: () {
                Educations educations = Educations(
                  institutionName: instituteName.text,
                  educationCity: city.text,
                  educationState: state.text,
                  fieldOfStudy: fieldOfStudy.text,
                  schoolHistory: isStudyHere ? 1 : 0,
                  educationStartMonth: startMonth,
                  educationEndMonth: isStudyHere ? "" : endMonth,
                  educationStartYear: startYear.toString(),
                  educationEndYear: isStudyHere ? "" : endYear.toString(),
                  educationCustomMessage: "",
                );
                if (formKey.currentState!.validate()) {
                  if (startYear == 0 || endYear == 0) {
                    showToast("Please select year");
                  } else {
                    if (context
                        .read<ResumeBloc>()
                        .resumeModel
                        .educations!
                        .isEmpty) {
                      context
                          .read<ResumeBloc>()
                          .add(AddEducationEvent(educations));
                    }
                    widget.pageController?.jumpToPage(2);
                  }
                } else {
                  showToast("Please Fill Details");
                }
              },
            );
          }),
        ],
      ),
    ));
  }

  int startYear = 0;
  int endYear = 0;
}

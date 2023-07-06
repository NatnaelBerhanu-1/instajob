// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bottom_sheet/bottom_sheet.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/custom_resume_card.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:insta_job/widgets/resume_tile.dart';

class WorkExpScreen extends StatefulWidget {
  final VoidCallback? onSkipTap;
  final PageController? pageController;
  const WorkExpScreen({Key? key, this.onSkipTap, this.pageController})
      : super(key: key);

  @override
  State<WorkExpScreen> createState() => _WorkExpScreenState();
}

class _WorkExpScreenState extends State<WorkExpScreen> {
  bool isWorkHere = false;

  TextEditingController jobTitle = TextEditingController();
  TextEditingController employee = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController message = TextEditingController();

  int startYear = 0;
  int endYear = 0;

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String startMonth = "";
  String endMonth = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                    onTap: () {
                      widget.pageController?.jumpToPage(1);
                    },
                    child: Container(
                      color: MyColors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 8, bottom: 8),
                        child: Image.asset(
                          MyImages.arrowBlueLeft,
                          height: 17,
                          width: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 0,
                  child: CommonText(
                    text: "Work Experience",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 0,
                  child: TextButton.icon(
                      onPressed: () {
                        WorkExperiences workExpModel = WorkExperiences(
                          jobTitle: jobTitle.text,
                          workCity: city.text,
                          workState: state.text,
                          employer: employee.text,
                          workHistory: isWorkHere ? 1 : 0,
                          workStartMonth: startMonth,
                          workEndMonth: isWorkHere ? "" : endMonth,
                          workStartYear: startYear.toString(),
                          workEndYear: isWorkHere ? "" : endYear.toString(),
                          workCustomMessage: "",
                        );
                        if (formKey.currentState!.validate()) {
                          if (!isWorkHere && (startYear == 0 || endYear == 0)) {
                            showToast("Please select year");
                          } else {
                            context
                                .read<ResumeBloc>()
                                .add(AddWorkExpEvent(workExpModel));
                            context
                                .read<ResumeBloc>()
                                .add(UserResumeLoadedEvent());
                            jobTitle.clear();
                            city.clear();
                            state.clear();
                            employee.clear();
                            startYear = 0;
                            endYear = 0;
                            startMonth = "";
                            endMonth = "";
                            message.clear();
                            isWorkHere = false;
                            setState(() {});
                          }
                        } else {
                          showToast("Please Fill Details");
                        }
                      },
                      icon: Icon(Icons.add, size: 18),
                      label: CommonText(
                        text: "Add",
                        fontSize: 13,
                        fontColor: MyColors.blue,
                      )),
                ),
                /*  Container(
                  height: 20,
                  width: 1,
                  color: MyColors.grey,
                ),
                Expanded(
                  flex: 0,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.delete,
                          color: MyColors.lightRed, size: 18),
                      label: CommonText(
                        text: "Delete",
                        fontSize: 13,
                        fontColor: MyColors.lightRed,
                      )),
                ),*/
              ],
            ),
            SizedBox(height: 15),
            CommonText(text: "Start With Your Most Recent Job"),
            SizedBox(height: 15),
            BlocBuilder<ResumeBloc, ResumeState>(builder: (context, rState) {
              var data = context.read<ResumeBloc>();
              if (rState is UserResumeLoaded) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.addNewWorkExp.length,
                    itemBuilder: (c, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: ResumeTile(
                          isWorkExp: true,
                          onTap: () {
                            data.add(DeleteWorkExp(
                                id: data.resumeModel.workExperiences?[index].id
                                    .toString(),
                                index: index));
                          },
                          workExperiences:
                              data.resumeModel.workExperiences?[index],
                          index: index + 1,
                        ),
                      );
                    });
              }
              if (rState is ResumeLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Text("%%% $rState");
            }),
            SizedBox(height: 15),
            CustomResumeCard(
              isWorkExp: true,
              value: isWorkHere,
              city: city,
              fieldOfStudy: employee,
              instituteName: jobTitle,
              state: state,
              endYear: CustomTextField(
                onPressed: isWorkHere
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
                hint:
                    isWorkHere ? "Year" : "${endYear == 0 ? "Year" : endYear}",
                hintColor: isWorkHere
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
                isWorkHere = !isWorkHere;
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
                list: isWorkHere
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
                validator: (val) =>
                    isWorkHere ? null : requiredValidationn(val ?? ""),
                hintText: Text(
                  "Month",
                  style: TextStyle(color: MyColors.grey),
                ),
              ),
            ),
            SizedBox(height: 15),
            CustomButton(
              title: "Skip",
              bgColor: MyColors.white,
              fontColor: MyColors.black,
              onTap: () {
                leaveSheet(context, pageController: widget.pageController!);
              },
            ),
            BlocBuilder<ResumeBloc, ResumeState>(builder: (context, rState) {
              var workExpList =
                  context.read<ResumeBloc>().resumeModel.workExperiences;
              return CustomIconButton(
                title: "Continue",
                backgroundColor:
                    workExpList!.isEmpty ? MyColors.lightBlue : MyColors.blue,
                borderColor:
                    workExpList.isEmpty ? MyColors.lightBlue : MyColors.blue,
                image: MyImages.arrowWhite,
                onclick: workExpList.isEmpty
                    ? null
                    : () {
                        widget.pageController?.jumpToPage(3);
                      },
              );
            }),
          ],
        ),
      ),
    );
  }
}

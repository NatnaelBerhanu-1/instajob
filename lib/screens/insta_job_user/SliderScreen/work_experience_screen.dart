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
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../model/education_model.dart';
import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

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
    return Scaffold(
        body: SingleChildScrollView(
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
                      onPressed: () {},
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
                      icon: Icon(Icons.delete,
                          color: MyColors.lightRed, size: 18),
                      label: CommonText(
                        text: "Delete",
                        fontSize: 13,
                        fontColor: MyColors.lightRed,
                      )),
                ),
              ],
            ),
            SizedBox(height: 15),
            CommonText(text: "Start With Your Most Recent Job"),
            SizedBox(height: 15),
            CustomTextField(
              label: "Job Title",
              hint: "Lipsum university,MI",
              controller: jobTitle,
              validator: (val) => requiredValidationn(val!),
            ),
            SizedBox(height: 15),
            CustomTextField(
              label: "Employee",
              hint: "e.g Business",
              controller: employee,
              validator: (val) => requiredValidationn(val!),
            ),
            SizedBox(height: 15),
            CustomTextField(
              label: "State",
              hint: "United State",
              controller: state,
              validator: (val) => requiredValidationn(val!),
            ),
            SizedBox(height: 15),
            CustomTextField(
              label: "City",
              hint: "New York",
              controller: city,
              validator: (val) => requiredValidationn(val!),
            ),
            SizedBox(height: 15),
            CustomDivider(
              title: "Work History",
              color: MyColors.black,
            ),
            // SizedBox(height: 15),
            CustomCheckbox(
              title: CommonText(
                  text: "Currently Work Here",
                  fontColor: MyColors.blue,
                  fontSize: 14),
              onchanged: (val) {
                isWorkHere = !isWorkHere;
                setState(() {});
              },
              value: isWorkHere,
            ),
            SizedBox(height: 9),
            CommonText(
              text: "Start Date",
              fontSize: 14,
              fontColor: MyColors.grey,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
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
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    width: 17,
                    height: 1,
                    color: MyColors.grey,
                  ),
                ),
                Expanded(
                    child: CustomTextField(
                  readOnly: true,
                  hint: "${startYear == 0 ? "Year" : startYear}",
                  hintColor: startYear == 0 ? MyColors.grey : MyColors.black,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                  onPressed: () {
                    buildDialog(context, barrierDismissible: true,
                        YearPickerDialog(onChange: (DateTime dateTime) {
                      Navigator.pop(context);
                      startYear = dateTime.year;
                      setState(() {});
                    }));
                  },
                )),
              ],
            ),
            SizedBox(height: 15),
            CommonText(
              text: "End Date",
              fontSize: 14,
              fontColor: MyColors.grey,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
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
                    validator: (val) => requiredValidationn(val ?? ""),
                    hintText: Text(
                      "Month",
                      style: TextStyle(color: MyColors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    width: 17,
                    height: 1,
                    color: MyColors.grey,
                  ),
                ),
                Expanded(
                    child: CustomTextField(
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
                  readOnly: true,
                  hint: "${endYear == 0 ? "Year" : endYear}",
                  hintColor: endYear == 0 ? MyColors.grey : MyColors.black,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                )),
              ],
            ),
            SizedBox(height: 15),
            CustomTextField(
              controller: message,
              hint: "Message...",
            ),
            CustomButton(
              title: "Skip",
              bgColor: MyColors.white,
              fontColor: MyColors.black,
              onTap: () {
                leaveSheet(context, pageController: widget.pageController!);
              },
            ),
            BlocBuilder<ResumeBloc, ResumeState>(builder: (context, rState) {
              return CustomIconButton(
                title: "Continue",
                backgroundColor: MyColors.blue,
                borderColor: MyColors.blue,
                image: MyImages.arrowWhite,
                onclick: () {
                  EducationModel educationModel = EducationModel(
                      jobTitle: jobTitle.text,
                      city: city.text,
                      state: state.text,
                      employer: employee.text,
                      workHistory: isWorkHere,
                      startMonth: startMonth,
                      endMonth: endMonth,
                      startYear: startYear.toString(),
                      endYear: endYear.toString());
                  if (formKey.currentState!.validate()) {
                    if (startYear == 0 || endYear == 0) {
                      showToast("Please select year");
                    } else {
                      context
                          .read<ResumeBloc>()
                          .add(AddWorkExpEvent(educationModel));
                      widget.pageController?.jumpToPage(3);
                    }
                  } else {
                    showToast("Please Fill Details");
                  }
                },
              );
            }),
          ],
        ),
      ),
    ));
  }
}

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
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/custom_resume_card.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:insta_job/widgets/resume_tile.dart';

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
  getData() {
    context.read<ResumeBloc>().addNewEducation =
        context.read<ResumeBloc>().resumeModel.educations ?? [];
    print("************** ${context.read<ResumeBloc>().addNewEducation}");
    setState(() {});
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                      if (formKey.currentState!.validate()) {
                        if (!isStudyHere) {
                          if (startYear == 0 || endYear == 0) {
                            showToast("Please select year");
                          }
                        } else {
                          context
                              .read<ResumeBloc>()
                              .add(AddEducationEvent(educations));
                          context
                              .read<ResumeBloc>()
                              .add(UserResumeLoadedEvent());

                          instituteName.clear();
                          city.clear();
                          state.clear();
                          fieldOfStudy.clear();
                          startYear = 0;
                          endYear = 0;
                          startMonth = "";
                          endMonth = "";
                          message.clear();
                          isStudyHere = false;
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
                    icon:
                        Icon(Icons.delete, color: MyColors.lightRed, size: 18),
                    label: CommonText(
                      text: "Delete",
                      fontSize: 13,
                      fontColor: MyColors.lightRed,
                    )),
              ),*/
            ],
          ),
          SizedBox(height: 10),
          context.read<ResumeBloc>().addNewEducation.isEmpty
              ? SizedBox()
              : BlocBuilder<ResumeBloc, ResumeState>(
                  builder: (context, snapshot) {
                  var data = context.read<ResumeBloc>();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.addNewEducation.length,
                      itemBuilder: (c, index) {
                        var educationData = data.resumeModel.educations?[index];

                        // instituteName.text =
                        //     "${educationData?.institutionName}";
                        // isStudyHere =
                        //     educationData?.schoolHistory == 0 ? false : true;
                        // fieldOfStudy.text = "${educationData?.fieldOfStudy}";
                        // city.text = "${educationData?.educationCity}";
                        // state.text = "${educationData?.educationState}";
                        // message.text =
                        //     "${educationData?.educationCustomMessage}";
                        // startMonth = "${educationData?.educationStartMonth}";
                        // endMonth = "${educationData?.educationEndMonth}";
                        // startYear = int.parse(
                        //     "${educationData?.educationStartYear ?? 0}");
                        // endYear = int.parse(
                        //     "${educationData?.educationEndYear ?? 0}");
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ResumeTile(
                            educations: educationData,
                            onTap: () {
                              data.add(DeleteEducation(
                                  id: educationData?.id.toString(),
                                  index: index));
                            },
                            index: index + 1,
                          ),
                        );
                      });
                }),
          SizedBox(height: 10),
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
              validator: (val) =>
                  isStudyHere ? null : requiredValidationn(val ?? ""),
              hintText: Text(
                "Month",
                style: TextStyle(color: MyColors.grey),
              ),
            ),
          ),
          CustomButton(
            title: "Skip",
            bgColor: MyColors.white,
            fontColor: MyColors.black,
            onTap: () {
              widget.pageController?.jumpToPage(2);
            },
          ),
          BlocBuilder<ResumeBloc, ResumeState>(builder: (context, rState) {
            var educationList =
                context.read<ResumeBloc>().resumeModel.educations;
            return CustomIconButton(
              title: "Continue",
              backgroundColor:
                  educationList == null ? MyColors.lightBlue : MyColors.blue,
              borderColor:
                  educationList == null ? MyColors.lightBlue : MyColors.blue,
              image: MyImages.arrowWhite,
              onclick: educationList == null
                  ? null
                  : () {
                      widget.pageController?.jumpToPage(2);
                    },
            );
          }),
        ],
      ),
    );
  }

  int startYear = 0;
  int endYear = 0;
}

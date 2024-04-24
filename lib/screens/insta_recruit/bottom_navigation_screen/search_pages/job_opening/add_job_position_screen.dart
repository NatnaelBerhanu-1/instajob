// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_opening_page.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../../../../bloc/global_cubit/global_cubit.dart';
import '../../../../../dialog/custom_dialog.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_images.dart';

enum SalariesOptionChosen { allSalaries, customRange }

class AddJobPositionScreen extends StatefulWidget {
  final bool isUpdate;
  final JobPosModel? jobPosModel;
  final CompanyModel? companyModel;
  const AddJobPositionScreen({
    Key? key,
    this.isUpdate = false,
    this.jobPosModel,
    this.companyModel,
  }) : super(key: key);

  @override
  State<AddJobPositionScreen> createState() => _AddJobPositionScreenState();
}

class _AddJobPositionScreenState extends State<AddJobPositionScreen> {
  TextEditingController jobDetails = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController requirements = TextEditingController();
  TextEditingController responsibility = TextEditingController();
  TextEditingController topSkills = TextEditingController();
  TextEditingController applicationReceivedSubject = TextEditingController();
  TextEditingController applicationReceivedContent = TextEditingController();
  TextEditingController disqualifiedReviewSubject = TextEditingController();
  TextEditingController disqualifiedReviewContent = TextEditingController();
  TextEditingController shortlistedReviewSubject = TextEditingController();
  TextEditingController shortlistedReviewContent = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late var uploadPhoto = context.read<PickImageCubit>();
  SalariesOptionChosen salariesOptionChosen = SalariesOptionChosen.allSalaries;

  updateData() {
    var value = context.read<GlobalCubit>();
    var uploadPhoto = context.read<PickImageCubit>();
    if (widget.isUpdate) {
      var model = widget.jobPosModel!;
      designation.text = model.designation ?? "";
      jobDetails.text = model.jobDetails ?? "";
      requirements.text = model.requirements ?? "";
      responsibility.text = model.responsibilities ?? "";
      applicationReceivedSubject.text = model.applicationReceivedSubject ?? "";
      applicationReceivedContent.text = model.applicationReceivedContent ?? "";
      disqualifiedReviewSubject.text = model.disqualifiedReviewSubject ?? "";
      disqualifiedReviewContent.text = model.disqualifiedReviewContent ?? "";
      shortlistedReviewSubject.text = model.shortlistedReviewSubject ?? "";
      shortlistedReviewContent.text = model.shortlistedReviewContent ?? "";
      value.skills = model.topSkills ?? [];
      value.jobTypeValue = model.jobsType ?? "";
      value.experienceLevelVal = model.experienceLevel ?? "";
      uploadPhoto.imgUrl = model.uploadPhoto ?? "";
      print('UPLOAD hudfgfhin ***************  ${uploadPhoto.imgUrl}');
    } else {
      if (Global.userModel?.automateMsgBtn == 1) {
        var model = Global.userModel!;
        applicationReceivedSubject.text = model.applicationReceivedSubject!;
        applicationReceivedContent.text = model.applicationReceivedContent!;
        disqualifiedReviewSubject.text = model.disqualifiedReviewSubject!;
        disqualifiedReviewContent.text = model.disqualifiedReviewContent!;
        shortlistedReviewSubject.text = model.shortlistedReviewSubject!;
        shortlistedReviewContent.text = model.shortlistedReviewContent!;
      }
    }
  }

  @override
  void initState() {
    // if (widget.isUpdate) {
    updateData();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: Form(
        // autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Stack(
                children: [
                  Image.asset(
                    MyImages.sCurve,
                    // height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: MyColors.lightGrey.withOpacity(.40),
                  ),
                  Positioned(
                    top: 40,
                    left: 5,
                    child: Row(
                      children: [
                        BlocBuilder<BottomBloc, BottomInitialState>(builder: (context, value) {
                          return ImageButton(
                            onTap: () {
                              var image = context.read<PickImageCubit>();
                              image.clearImgUrl();
                              context.read<GlobalCubit>().skills.clear();
                              context.read<BottomBloc>().add(SetScreenEvent(true,
                                  screenName: JobOpeningScreen(companyModel: widget.companyModel)));
                              // Navigator.pop(context);
                            },
                            height: 28,
                            width: 28,
                            image: MyImages.backArrow,
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.isUpdate ? "Edit Listing" : "Add Job Positions",
                                style: TextStyle(color: MyColors.black, fontSize: 16.5, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.isUpdate ? "Update job details" : "Add job details for new opening",
                                style: TextStyle(color: MyColors.grey, fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 52),
                        widget.isUpdate
                            ? BlocBuilder<BottomBloc, BottomInitialState>(builder: (context, value) {
                                return GestureDetector(
                                  onTap: () {
                                    buildDialog(
                                        context,
                                        CustomDialog(
                                          desc1: "You want to Remove Listing",
                                          okOnTap: () {
                                            context
                                                .read<JobPositionBloc>()
                                                .add(DeleteJobPositionEvent(jobId: "${widget.jobPosModel?.id}"));
                                            context
                                                .read<JobPositionBloc>()
                                                .add(LoadJobPosListEvent(companyId: "${widget.companyModel?.id}"));
                                            context.read<BottomBloc>().add(SetScreenEvent(true,
                                                screenName: JobOpeningScreen(companyModel: widget.companyModel)));
                                            AppRoutes.push(context, BottomNavScreen());
                                          },
                                          cancelOnTap: () {
                                            Navigator.pop(context);
                                          },
                                        ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: MyColors.darkRed)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                                      child: Text(
                                        "Remove Listing",
                                        style: TextStyle(fontSize: 13, color: MyColors.darkRed),
                                      ),
                                    ),
                                  ),
                                );
                              })
                            : SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                child: BlocConsumer<ValidationCubit, InitialValidation>(listener: (context, state) {
                  if (state is RequiredValidation) {
                    showToast(state.require);
                  }
                }, builder: (context, state) {
                  var validate = context.read<ValidationCubit>();
                  return ListView(
                    children: [
                      CustomTextField(
                          controller: designation,
                          label: "Enter Job Title",
                          lblColor: MyColors.black,
                          hint: "Front end developer",
                          // validator: (val) {
                          //   validate.requiredValidation(val!, "!!!!!!!");
                          //   return null;
                          // },
                          validator: (val) => requiredValidation(val!, 'Job Title')),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: jobDetails,
                        label: "Enter Job Details",
                        lblColor: MyColors.black,
                        hint: "Sed ut perspisious",
                        maxLine: 5,
                        validator: (val) => requiredValidation(val!, 'JobDetails'),
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: requirements,
                        label: "Enter Requirements",
                        lblColor: MyColors.black,
                        hint: "Sed ut perspisious",
                        maxLine: 5,
                        validator: (val) => requiredValidation(val!, "Requirements"),
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: responsibility,
                        label: "Enter Responsibilities",
                        lblColor: MyColors.black,
                        hint: "",
                        maxLine: 5,
                        validator: (val) => requiredValidation(val!, "Responsibilities"),
                      ),
                      SizedBox(height: 15),
                      BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                        var skillList = context.read<GlobalCubit>();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Top Skills",
                              style: TextStyle(color: MyColors.black, fontSize: 13.5, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5),
                            skillList.skills.isEmpty
                                ? SizedBox()
                                : GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 4 / 1,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    // scrollDirection: Axis.horizontal,
                                    // primary: false,
                                    shrinkWrap: true,
                                    itemCount: skillList.skills.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: MyColors.lightBlue.withOpacity(.20),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: CommonText(
                                                    text: skillList.skills[index],
                                                    fontColor: MyColors.blue,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillList.removeSkill(index);
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: MyColors.red,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                            Expanded(
                              flex: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: topSkills,
                                      hint: "",
                                      textCapitalization: TextCapitalization.words,
                                      // validator: (val) =>
                                      //     validate.requiredValidation(
                                      //         val!, "Skills"),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (topSkills.text.isNotEmpty) {
                                        skillList.topSkills(topSkills.text);
                                        topSkills.clear();
                                      } else {
                                        showToast('Please fill the text');
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10.0, left: 10, top: 15),
                                      child: Container(
                                        decoration: BoxDecoration(color: MyColors.blue, shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Icon(
                                            Icons.add,
                                            color: MyColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 15),
                      CommonText(
                        text: "Salaries",
                        fontSize: 14,
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                        var values = context.read<GlobalCubit>();
                        return CustomCommonCard(
                          borderColor: MyColors.grey.withOpacity(.30),
                          borderRadius: BorderRadius.circular(7),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      salariesOptionChosen =
                                          SalariesOptionChosen.allSalaries;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: "All Salaries",
                                          fontSize: 12,
                                          fontColor: salariesOptionChosen ==
                                                  SalariesOptionChosen
                                                      .allSalaries
                                              ? MyColors.blue
                                              : MyColors.grey,
                                        ),
                                        if (salariesOptionChosen ==
                                            SalariesOptionChosen.allSalaries)
                                          ImageButton(
                                            image: MyImages.verified,
                                            padding: EdgeInsets.zero,
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                divider(color: MyColors.grey.withOpacity(.40)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      salariesOptionChosen =
                                          SalariesOptionChosen.customRange;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonText(
                                        text: "Custom Range",
                                        fontSize: 14,
                                        fontColor: MyColors.grey,
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            CommonText(
                                              text:
                                                  "${values.rangeValue.start.toStringAsFixed(0)}k - ${values.rangeValue.end.toStringAsFixed(0)}k",
                                              fontSize: 14,
                                              fontColor: MyColors.grey,
                                            ),
                                            if (salariesOptionChosen ==
                                                SalariesOptionChosen
                                                    .customRange)
                                              Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  ImageButton(
                                                    image: MyImages.verified,
                                                    padding: EdgeInsets.zero,
                                                  )
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                RangeSlider(
                                  values: values.rangeValue,
                                  onChanged: (val) {
                                    values.rangeValues(val);
                                  },
                                  max: 100,
                                  min: 0,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 15),
                      CommonText(
                        text: "Area Distance",
                        fontSize: 14,
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                        var value = context.read<GlobalCubit>();
                        return CustomCommonCard(
                          borderColor: MyColors.grey.withOpacity(.30),
                          borderRadius: BorderRadius.circular(7),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: "With in ${value.range.toStringAsFixed(0)} miles",
                                  fontSize: 12,
                                  fontColor: MyColors.blue,
                                ),
                                SizedBox(height: 10),
                                divider(color: MyColors.grey.withOpacity(.40)),
                                SizedBox(height: 10),
                                Slider(
                                  value: value.range,
                                  onChanged: (val) {
                                    value.rangeVal(val);
                                  },
                                  max: 100,
                                  min: 0,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 15),
                      CommonText(
                        text: "Jobs Type",
                        fontSize: 14,
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
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
                                      value: value.jobTypeValue,
                                      selectedValue: "Full Time",
                                      onTap: () {
                                        // validate.checkBoxValue();
                                        value.jobType("Full Time");
                                      },
                                    ),
                                    divider(color: MyColors.grey.withOpacity(.40)),
                                    jobTypeTile(
                                      title: "Part Time",
                                      value: value.jobTypeValue,
                                      selectedValue: "Part Time",
                                      onTap: () {
                                        value.jobType("Part Time");
                                      },
                                    ),
                                    divider(color: MyColors.grey.withOpacity(.40)),
                                    jobTypeTile(
                                      title: "Contact",
                                      value: value.jobTypeValue,
                                      selectedValue: "Contact",
                                      onTap: () {
                                        value.jobType("Contact");
                                      },
                                    ),
                                    divider(color: MyColors.grey.withOpacity(.40)),
                                    jobTypeTile(
                                      title: "Temporary",
                                      value: value.jobTypeValue,
                                      selectedValue: "Temporary",
                                      onTap: () {
                                        value.jobType("Temporary");
                                      },
                                    ),
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
                                      value: value.experienceLevelVal,
                                      selectedValue: "All Experience Level",
                                      onTap: () {
                                        value.experienceLevel("All Experience Level");
                                      },
                                    ),
                                    divider(color: MyColors.grey.withOpacity(.40)),
                                    jobTypeTile(
                                      title: "Entry Level",
                                      value: value.experienceLevelVal,
                                      selectedValue: "Enter Level",
                                      onTap: () {
                                        value.experienceLevel("Enter Level");
                                      },
                                    ),
                                    divider(color: MyColors.grey.withOpacity(.40)),
                                    jobTypeTile(
                                      title: "Mid Level",
                                      value: value.experienceLevelVal,
                                      selectedValue: "Mid Level",
                                      onTap: () {
                                        value.experienceLevel("Mid Level");
                                      },
                                    ),

                                    divider(color: MyColors.grey.withOpacity(.40)),
                                    jobTypeTile(
                                      title: "Senior Level",
                                      value: value.experienceLevelVal,
                                      selectedValue: "Senior Level",
                                      onTap: () {
                                        value.experienceLevel("Senior Level");
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

                      /// display image

                      uploadPhotoCard(context, isUpdate: widget.isUpdate, url: widget.jobPosModel?.uploadPhoto),
                      SizedBox(height: 20),
                      Global.userModel?.automateMsgBtn == 0
                          ? CommonText(
                              text: "Kindly enable automate message for better experience",
                              fontSize: 12,
                              fontColor: MyColors.blue,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  text: "This will be sent the morning after rejecting a candidate",
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
                              ],
                            ),
                      SizedBox(height: 20),
                      BlocConsumer<JobPositionBloc, JobPosState>(listener: (context, state) {
                        var bottomNav = context.read<BottomBloc>();

                        if (state is JobErrorState) {
                          showToast(state.error);
                        }
                        if (state is JobPosLoaded) {
                          bottomNav.add(
                              SetScreenEvent(true, screenName: JobOpeningScreen(companyModel: widget.companyModel)));
                          AppRoutes.push(context, BottomNavScreen());
                        }
                      }, builder: (context, state) {
                        var jobPosition = context.read<JobPositionBloc>();
                        return CustomIconButton(
                          image: MyImages.arrowWhite,
                          loading: state is JobPosLoading ? true : false,
                          title: widget.isUpdate ? "Edit Job Position" : "Post Job Position",
                          backgroundColor: MyColors.blue,
                          fontColor: MyColors.white,
                          borderColor: MyColors.blue,
                          onclick: () async {
                            print("ID ++++++++++++++ ||||||||||| ${context.read<CompanyBloc>().companyModel.id}");
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              var value = context.read<GlobalCubit>();
                              var uploadPhoto = context.read<PickImageCubit>();
                              String salary = value.rangeValue.end.toStringAsFixed(0);
                              jobPosition.add(AddJobPositionEvent(
                                companyId: widget.companyModel?.id.toString(),
                                isUpdate: widget.isUpdate ? true : false,
                                id: widget.isUpdate ? widget.jobPosModel?.id.toString() : "",
                                designation: designation.text,
                                applicationReceivedContent: applicationReceivedContent.text,
                                applicationReceivedSubject: applicationReceivedSubject.text,
                                areaDistance: value.range.toStringAsFixed(0),
                                disqualifiedReviewContent: disqualifiedReviewContent.text,
                                disqualifiedReviewSubject: disqualifiedReviewSubject.text,
                                experienceLevel: value.experienceLevelVal,
                                jobDetails: jobDetails.text,
                                jobsType: value.jobTypeValue,
                                requirements: requirements.text,
                                responsibility: responsibility.text,
                                salaries: salary,
                                shortlistedReviewContent: shortlistedReviewContent.text,
                                shortlistedReviewSubject: shortlistedReviewSubject.text,
                                topSkills: value.skills,
                                uploadPhoto: uploadPhoto.imgUrl,
                              ));
                              AppRoutes.push(context, JobOpeningScreen(companyModel: widget.companyModel));

                              // jobPosition.add(LoadJobPosListEvent());
                            } else {
                              print('@@@@  ||||||||||||||  @@@@');
                            }
                          },
                        );
                      }),
                      SizedBox(height: 10)
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Row(
                                  children: List.generate(
                                      skillList.skills.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CustomCommonCard(
                                        bgColor:
                                            MyColors.lightBlue.withOpacity(.20),
                                        borderRadius: BorderRadius.circular(5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CommonText(
                                            text: skillList.skills[index],
                                            fontColor: MyColors.blue,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
*/

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../../../globals.dart';
import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

class EducationScreen extends StatefulWidget {
  final bool isWork;
  final VoidCallback? onSkipTap;
  final VoidCallback? onContinueTap;
  final PageController? pageController;
  const EducationScreen(
      {Key? key,
      this.isWork = false,
      this.onSkipTap,
      this.onContinueTap,
      this.pageController})
      : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  bool isStudyHere = false;

  bool isWorkHere = false;
  TextEditingController instituteName = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController employee = TextEditingController();
  TextEditingController fieldOfStudy = TextEditingController();
  TextEditingController educationState = TextEditingController();
  TextEditingController educationCity = TextEditingController();
  TextEditingController workCity = TextEditingController();
  TextEditingController workState = TextEditingController();
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
        body: ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 0,
              child: ImageButton(
                onTap: () {
                  if (widget.isWork) {
                    widget.pageController?.animateToPage(1,
                        duration: Duration(seconds: 1), curve: Curves.ease);
                  } else {
                    widget.pageController?.animateToPage(0,
                        duration: Duration(seconds: 1), curve: Curves.ease);
                  }
                },
                image: MyImages.arrowBlueLeft,
                padding: EdgeInsets.zero,
                height: 17,
                width: 17,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 0,
              child: CommonText(
                text: widget.isWork ? "Work Experience" : "Education",
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
                  icon: Icon(Icons.delete, color: MyColors.lightRed, size: 18),
                  label: CommonText(
                    text: "Delete",
                    fontSize: 13,
                    fontColor: MyColors.lightRed,
                  )),
            ),
          ],
        ),
        SizedBox(height: 15),
        widget.isWork
            ? CommonText(
                text: "Start With Your Most Recent Job",
              )
            : SizedBox(),
        widget.isWork ? SizedBox(height: 15) : SizedBox(),
        CustomTextField(
          label: widget.isWork ? "Job Title" : "Institution Name",
          hint: "Lipsum university,MI",
          controller: widget.isWork ? jobTitle : instituteName,
        ),
        SizedBox(height: 15),
        CustomTextField(
          label: widget.isWork ? "Employee" : "Field of Study",
          hint: "e.g Business",
          controller: widget.isWork ? employee : fieldOfStudy,
        ),
        SizedBox(height: 15),
        CustomTextField(
          label: "State",
          hint: "United State",
          controller: widget.isWork ? workState : educationState,
        ),
        SizedBox(height: 15),
        CustomTextField(
          label: "City",
          hint: "New York",
          controller: widget.isWork ? workCity : educationCity,
        ),
        SizedBox(height: 15),
        CustomDivider(
          title: widget.isWork ? "Work History" : "School History",
          color: MyColors.black,
        ),
        // SizedBox(height: 15),
        CustomCheckbox(
          title: CommonText(
              text: widget.isWork
                  ? "Currently Work Here"
                  : "Currently Study Here",
              fontColor: MyColors.blue),
          onchanged: (val) {
            if (widget.isWork) {
              isWorkHere = !isWorkHere;
            } else {
              isStudyHere = !isStudyHere;
            }
            setState(() {});
          },
          value: widget.isWork ? isWorkHere : isStudyHere,
        ),
        SizedBox(height: 3),

        Row(
          children: [
            Expanded(
                child: CustomTextField(
              label: "Start Date",
              hint: "Month",
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 30,
              ),
            )),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 20),
              child: Container(
                width: 17,
                height: 1,
                color: MyColors.grey,
              ),
            ),
            Expanded(
                child: CustomTextField(
              label: "",
              hint: "Year",
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 30,
              ),
            )),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              label: "End Date",
              hint: "Month",
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 30,
              ),
            )),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 20),
              child: Container(
                width: 17,
                height: 1,
                color: MyColors.grey,
              ),
            ),
            Expanded(
                child: CustomTextField(
              onPressed: () {
                chooseDate(context);
              },
              readOnly: true,
              label: "",
              hint: "Year",
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 30,
              ),
            )),
          ],
        ),
        SizedBox(height: 15),
        CustomTextField(
          hint: "Message...",
        ),
        CustomButton(
          title: "Skip",
          bgColor: MyColors.white,
          fontColor: MyColors.black,
          onTap: widget.onSkipTap,
        ),
        CustomIconButton(
          title: "Continue",
          backgroundColor: MyColors.blue,
          borderColor: MyColors.blue,
          image: MyImages.arrowWhite,
          onclick: widget.onContinueTap,
        ),
      ],
    ));
  }

  String selectedDate = "${DateTime.now()}";

  chooseDate(context) async {
    DateTime date = DateTime.now();
    date = await selectYear(context, date);
    selectedDate = DateFormat('yyyy').format(date);
    print(" //////// $selectedDate");
    setState(() {});
  }
}

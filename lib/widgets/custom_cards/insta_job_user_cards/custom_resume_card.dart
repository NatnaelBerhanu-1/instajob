// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class CustomResumeCard extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController? instituteName;
  final TextEditingController? fieldOfStudy;
  final TextEditingController? state;
  final TextEditingController? city;
  final TextEditingController? message;
  final ValueChanged? onChange;
  final Widget? startMonthDp;
  final Widget? endMonthDp;
  final bool? value;
  final bool isWorkExp;
  final bool inNew;
  final Widget? startYear;
  final Widget? endYear;
  CustomResumeCard(
      {Key? key,
      this.onTap,
      this.instituteName,
      this.fieldOfStudy,
      this.state,
      this.city,
      this.onChange,
      this.value,
      this.startYear,
      this.endYear,
      this.startMonthDp,
      this.endMonthDp,
      this.inNew = false,
      this.isWorkExp = false,
      this.message})
      : super(key: key);

  @override
  State<CustomResumeCard> createState() => _CustomResumeCardState();
}

class _CustomResumeCardState extends State<CustomResumeCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCommonCard(
      boxShadow: normalBoxShadow,
      borderColor: MyColors.lightgrey,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.inNew
                ? Align(
                    alignment: Alignment.topRight,
                    child: ImageButton(
                      image: MyImages.cancel,
                      padding: EdgeInsets.zero,
                      height: 19,
                      onTap: widget.onTap,
                      // onTap: () {
                      //   data.add(DeleteEducation(index));
                      // },
                    ))
                : SizedBox(),
            CustomTextField(
              label: widget.isWorkExp ? "Job Title" : "Institution Name",
              hint: widget.isWorkExp ? "PHP Developer" : "Lipsum university,MI",
              controller: widget.instituteName,
              validator: (val) => requiredValidationn(val!),
            ),
            SizedBox(height: 10),
            CustomTextField(
              label: widget.isWorkExp ? "Employee" : "Field of Study",
              hint: "e.g Business",
              controller: widget.fieldOfStudy,
              validator: (val) => requiredValidationn(val!),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "State",
                    hint: "United State",
                    controller: widget.state,
                    validator: (val) => requiredValidationn(val!),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    label: "City",
                    hint: "New York",
                    controller: widget.city,
                    validator: (val) => requiredValidationn(val!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomDivider(
              title: widget.isWorkExp ? "Work History" : "School History",
              color: MyColors.black,
            ),
            // SizedBox(height: 15),
            CustomCheckbox(
              title: CommonText(
                  text: widget.isWorkExp
                      ? "Currently Work Here"
                      : "Currently Study Here",
                  fontColor: MyColors.blue,
                  fontSize: 14),
              onchanged: widget.onChange,
              value: widget.value,
            ),
            SizedBox(height: 5),
            CommonText(
              text: "Start Date",
              fontSize: 14,
              fontColor: MyColors.grey,
            ),
            Row(
              children: [
                Expanded(
                  child: widget.startMonthDp ?? SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 0),
                  child: Container(
                    width: 17,
                    height: 1,
                    color: MyColors.grey,
                  ),
                ),
                Expanded(child: widget.startYear ?? SizedBox()),
              ],
            ),
            SizedBox(height: 10),
            CommonText(
              text: "End Date",
              fontSize: 14,
              fontColor: MyColors.grey,
            ),
            Row(
              children: [
                Expanded(
                  child: widget.endMonthDp ?? SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 0),
                  child: Container(
                    width: 17,
                    height: 1,
                    color: MyColors.grey,
                  ),
                ),
                Expanded(child: widget.endYear ?? SizedBox()),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              controller: widget.message,
              hint: "Message...",
            ),
          ],
        ),
      ),
    );
  }
}

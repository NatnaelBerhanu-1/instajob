// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

class EducationScreen extends StatelessWidget {
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
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageButton(
                onTap: () {
                  pageController?.animateToPage(0,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                },
                image: MyImages.arrowBlueLeft,
                padding: EdgeInsets.zero,
                height: 17,
                width: 17,
              ),
              SizedBox(width: 15),
              CommonText(
                text: isWork ? "Work Experience" : "Education",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              Spacer(),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: CommonText(
                    text: "Add",
                    fontColor: MyColors.blue,
                  )),
              Container(
                height: 20,
                width: 1,
                color: MyColors.grey,
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: MyColors.lightRed),
                  label: CommonText(
                    text: "Delete",
                    fontColor: MyColors.lightRed,
                  )),
            ],
          ),
          SizedBox(height: 15),
          isWork
              ? CommonText(
                  text: "Start With Your Most Recent Job",
                )
              : SizedBox(),
          isWork ? SizedBox(height: 15) : SizedBox(),
          CustomTextField(
            label: isWork ? "Job Title" : "Institution Name",
            hint: "Lipsum university,MI",
          ),
          SizedBox(height: 15),
          CustomTextField(
            label: isWork ? "Employee" : "Field of Study",
            hint: "e.g Business",
          ),
          SizedBox(height: 15),
          CustomTextField(
            label: "State",
            hint: "United State",
          ),
          SizedBox(height: 15),
          CustomTextField(
            label: "City",
            hint: "New York",
          ),
          SizedBox(height: 15),
          CustomDivider(
            title: isWork ? "Work History" : "School History",
            color: MyColors.black,
          ),
          // SizedBox(height: 15),
          CustomCheckbox(
            title: CommonText(
                text: "Currently Study Here", fontColor: MyColors.blue),
            onchanged: (val) {},
            value: true,
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
            onTap: onSkipTap,
          ),
          CustomIconButton(
            title: "Continue",
            backgroundColor: MyColors.blue,
            borderColor: MyColors.blue,
            image: MyImages.arrowWhite,
            onclick: onContinueTap,
          ),
        ],
      ),
    ));
  }
}

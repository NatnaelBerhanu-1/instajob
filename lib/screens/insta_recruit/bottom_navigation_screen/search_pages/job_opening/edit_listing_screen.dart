// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/provider/bottom_provider.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_images.dart';

class EditListing extends StatefulWidget {
  final bool isUpdate;
  const EditListing({Key? key, this.isUpdate = false}) : super(key: key);

  @override
  State<EditListing> createState() => _EditListingState();
}

class _EditListingState extends State<EditListing> {
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
          leading: Consumer<BottomProvider>(builder: (context, value, _) {
            return ImageButton(
              onTap: () {
                print("editl");
                value.setSelectedScreen(false,
                    screenName: BottomNavigationScreen());
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
                          border: Border.all(color: MyColors.red)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Remove Listing",
                          style: TextStyle(fontSize: 13, color: MyColors.red),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: ListView(
            children: [
              CustomTextField(
                label: "Enter Job Details",
                lblColor: MyColors.black,
                hint: "Sed ut perspisious",
                maxLine: 5,
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: "Enter Requirements",
                lblColor: MyColors.black,
                hint: "Sed ut perspisious",
                maxLine: 5,
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: "Enter Responsibility",
                lblColor: MyColors.black,
                hint: "",
                maxLine: 5,
              ),
              SizedBox(height: 15),
              CustomTextField(
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
              CustomCommonCard(
                borderColor: MyColors.grey.withOpacity(.30),
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: "Full Time",
                            fontSize: 12,
                            fontColor: MyColors.blue,
                          ),
                          ImageButton(
                            image: MyImages.verified,
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      divider(color: MyColors.grey.withOpacity(.40)),
                      SizedBox(height: 5),
                      CommonText(
                        padding: true,
                        text: "Part Time",
                        fontSize: 14,
                        fontColor: MyColors.grey,
                      ),
                      SizedBox(height: 5),
                      divider(color: MyColors.grey.withOpacity(.40)),
                      SizedBox(height: 5),
                      CommonText(
                        padding: true,
                        text: "Contact",
                        fontSize: 14,
                        fontColor: MyColors.grey,
                      ),
                      SizedBox(height: 5),
                      divider(color: MyColors.grey.withOpacity(.40)),
                      SizedBox(height: 5),
                      CommonText(
                        padding: true,
                        text: "Temporary",
                        fontSize: 14,
                        fontColor: MyColors.grey,
                      ),
                      SizedBox(height: 5),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: "All Experience Level",
                            fontSize: 12,
                            fontColor: MyColors.blue,
                          ),
                          ImageButton(
                            image: MyImages.verified,
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      divider(color: MyColors.grey.withOpacity(.40)),
                      SizedBox(height: 5),
                      CommonText(
                        padding: true,
                        text: "Entry Level",
                        fontSize: 14,
                        fontColor: MyColors.grey,
                      ),
                      SizedBox(height: 5),
                      divider(color: MyColors.grey.withOpacity(.40)),
                      SizedBox(height: 5),
                      CommonText(
                        padding: true,
                        text: "Mid Level",
                        fontSize: 14,
                        fontColor: MyColors.grey,
                      ),
                      SizedBox(height: 5),
                      divider(color: MyColors.grey.withOpacity(.40)),
                      SizedBox(height: 5),
                      CommonText(
                        padding: true,
                        text: "Senior Level",
                        fontSize: 14,
                        fontColor: MyColors.grey,
                      ),
                      SizedBox(height: 5),
                      // divider(color: MyColors.grey.withOpacity(.40)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              uploadPhotoCard(),
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
                label: "Subject",
                hint: "Your application at [Company Name]",
              ),
              SizedBox(height: 20),
              CustomTextField(
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
                label: "Subject",
                hint: "Your application at [Company Name]",
              ),
              SizedBox(height: 20),
              CustomTextField(
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
                label: "Subject",
                hint: "Your application at [Company Name]",
              ),
              SizedBox(height: 20),
              CustomTextField(
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
              CustomIconButton(
                image: MyImages.arrowWhite,
                title:
                    widget.isUpdate ? "Edit Job Position" : "Post Job Position",
                backgroundColor: MyColors.blue,
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
              ),
            ],
          ),
        ));
  }
}

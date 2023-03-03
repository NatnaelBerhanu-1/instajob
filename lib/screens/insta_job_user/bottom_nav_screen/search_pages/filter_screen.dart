// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_card.dart';

import '../../../../widgets/custom_divider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
                title: "Filters",
                centerTitle: false,
                leadingWidth: 6,
                toolbarHeight: 45,
                actions: Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 10),
                  child: CustomCommonCard(
                    onTap: () {},
                    borderColor: MyColors.blue,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 13, color: MyColors.blue),
                      ),
                    ),
                  ),
                ))),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              // divider(color: MyColors.grey.withOpacity(.40)),
              CustomFilterCard(
                  title: "Sort By Relevance",
                  heading: "Sort By",
                  children: [
                    CommonText(
                      text: "Sort By Date",
                      fontSize: 13,
                      fontColor: MyColors.grey,
                    ),
                  ]),
              SizedBox(height: 20),
              CustomFilterCard(
                  title: "All Jobs",
                  heading: "Duration",
                  children: [
                    buildTitleTile(label: "Last 24 Hours"),
                    buildTitleTile(label: "Last 3 Days"),
                    buildTitleTile(label: "Last 7 Days"),
                    buildTitleTile(label: "Last 14 Days", hideDivider: true),
                    // CommonText(
                    //   text: "Last 24 Hours",
                    //   fontSize: 13,
                    //   fontColor: MyColors.grey,
                    // ),
                  ]),
              SizedBox(height: 20),
              CustomFilterCard(
                  title: "All Salaries",
                  heading: "Salaries",
                  children: [
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
                    // CommonText(
                    //   text: "Last 24 Hours",
                    //   fontSize: 13,
                    //   fontColor: MyColors.grey,
                    // ),
                  ]),
              SizedBox(height: 20),
              CommonText(
                text: "Area Distance",
                fontSize: 14,
              ),
              SizedBox(height: 20),
              CustomCommonCard(
                borderColor: MyColors.grey.withOpacity(.30),
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "With in 25 miles",
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
              SizedBox(height: 20),
              CustomFilterCard(
                  title: "InstaJob Only",
                  heading: "Jobs",
                  children: [
                    CommonText(
                      text: "All Jobs",
                      fontSize: 13,
                      fontColor: MyColors.grey,
                    ),
                  ]),
              SizedBox(height: 20),
              CustomFilterCard(
                  title: "Full Time",
                  heading: "Job Types",
                  children: [
                    buildTitleTile(label: "Part Time"),
                    buildTitleTile(label: "Contact"),
                    buildTitleTile(label: "Temporary", hideDivider: true),
                    // CommonText(
                    //   text: "Last 24 Hours",
                    //   fontSize: 13,
                    //   fontColor: MyColors.grey,
                    // ),
                  ]),
              SizedBox(height: 20),
              CustomFilterCard(
                  title: "Experience Level",
                  heading: "All Experience Level",
                  children: [
                    buildTitleTile(label: "Entry Level"),
                    buildTitleTile(label: "Mid Level"),
                    buildTitleTile(label: "Senior Level", hideDivider: true),
                    // CommonText(
                    //   text: "Last 24 Hours",
                    //   fontSize: 13,
                    //   fontColor: MyColors.grey,
                    // ),
                  ]),
              SizedBox(height: 40),
              CustomIconButton(
                image: MyImages.arrowWhite,
                title: "Update Now",
              )
            ],
          ),
        ));
  }
}

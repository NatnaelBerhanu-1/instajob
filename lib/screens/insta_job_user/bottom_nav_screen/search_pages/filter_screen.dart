// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_card.dart';

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
          child: Column(
            children: [
              // divider(color: MyColors.grey.withOpacity(.40)),
              CustomFilterCard(
                  title: "Sort By Relevance",
                  heading: "Sort By",
                  children: [
                    Text('data'),
                    Text('data'),
                  ])
            ],
          ),
        ));
  }
}

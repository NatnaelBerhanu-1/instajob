// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/custom_career_tile.dart';

import '../../widgets/custom_app_bar.dart';

class CareerClusterScreen extends StatelessWidget {
  const CareerClusterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Browse by career cluster",
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Column(
            children: [
              CustomCommonCard(
                borderRadius: BorderRadius.circular(30),
                borderColor: MyColors.lightgrey,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CommonText(
                            text: "Business Management & Administration",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: CustomCommonCard(
                          bgColor: MyColors.blue,
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CommonText(
                              text: "Go",
                              fontColor: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 8,
                    // shrinkWrap: true,
                    itemBuilder: (c, i) {
                      return CustomCareerTile();
                    }),
              )
            ],
          ),
        ));
  }
}

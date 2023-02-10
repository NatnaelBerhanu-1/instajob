// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_tile.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/search_job_tile.dart';
import 'package:insta_job/widgets/custom_chip.dart';

import '../../../../utils/my_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../insta_recruit/bottom_navigation_screen/user_account/setting_pages/save_card_screen.dart';
import 'filter_screen.dart';

class SearchJobsScreen extends StatefulWidget {
  const SearchJobsScreen({Key? key}) : super(key: key);

  @override
  State<SearchJobsScreen> createState() => _SearchJobsScreenState();
}

class _SearchJobsScreenState extends State<SearchJobsScreen> {
  int sqIndex = 0;
  int sIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Search Jobs",
              centerTitle: false,
              leadingImage: "",
              leadingWidth: 5,
              actions: ImageButton(
                image: MyImages.searchBlue,
                padding: EdgeInsets.only(left: 10, right: 20),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            color: MyColors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 40,
                          // width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: MyColors.blue),
                              color: MyColors.white),
                          child: Row(
                            children: List.generate(
                                list.length,
                                (index) => Expanded(
                                      child: Container(
                                        height: 40,
                                        // width: MediaQuery.of(context).size.width - 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: MyColors.white),
                                            color: MyColors.white),
                                        child: CustomFilterTile(
                                          onClick: () {
                                            sqIndex = index;
                                            setState(() {});
                                          },
                                          selectedIndex: sqIndex,
                                          index: index,
                                          title: list[index],
                                        ),
                                      ),
                                    )),
                          )),
                    ),
                    SizedBox(width: 7),
                    Expanded(
                        flex: 0,
                        child: GestureDetector(
                          onTap: () {
                            push(context: context, screen: FilterScreen());
                          },
                          child: Container(
                            color: MyColors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                MyImages.filter,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: CustomSearchChip(
                      onTap: () {
                        sIndex = 1;
                        setState(() {});
                      },
                      image: MyImages.suitcase,
                      index: 1,
                      selectedIndex: sIndex,
                      title: "Search Jobs",
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: CustomSearchChip(
                      onTap: () {
                        sIndex = 2;
                        setState(() {});
                      },
                      index: 2,
                      selectedIndex: sIndex,
                      title: "Search Companies",
                    )),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 5),
                          child: sIndex == 1
                              ? SearchJobTile()
                              : AssignCompaniesTile(
                                  leadingImage: MyImages.businessAndTrade,
                                  title: "Ford",
                                ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

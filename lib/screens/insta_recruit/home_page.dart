// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_job_user/SliderScreen/Slider_screen.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/user_account/save_jobs/save_jobs_screen.dart';
import 'package:insta_job/screens/insta_job_user/career_cluster_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/automate_messages/automate_message_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/setting_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/subscribe_pages/job_board_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/user_tile/custom_acc_details.dart';

import 'bottom_navigation_screen/user_account/feedback/feedback_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? index;

  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<IndexBloc>().sIndex;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15),
          child:
              BlocBuilder<IndexBloc, InitialState>(builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            MyImages.user_4x,
                            color: MyColors.blue.withOpacity(.20),
                            height: 100,
                            width: 100,
                          ),
                          CommonText(
                            text: "John Smith",
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            fontColor: MyColors.blue,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        color: MyColors.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CommonText(
                    text: "Account Details",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: MyColors.grey,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Global.type == "user"
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: CustomAccDetails(
                                onTap: () {
                                  index = 0;
                                  context.read<IndexBloc>().changeIndex(index);
                                  AppRoutes.push(context, SliderScreen());
                                },
                                index: 0,
                                selectedIndex: selectedIndex,
                                width: double.infinity,
                                img: MyImages.resume1,
                                title: "Edit Resume/Bio",
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(width: 15),
                    Expanded(
                      child: CustomAccDetails(
                        onTap: () {
                          index = 1;
                          context.read<IndexBloc>().changeIndex(index);
                          AppRoutes.push(context, FeedBackScreen());
                        },
                        index: 1,
                        selectedIndex: selectedIndex,
                        width: double.infinity,
                        img: MyImages.rate,
                        title: "Feedbacks",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomAccDetails(
                              onTap: () {
                                index = 2;
                                context.read<IndexBloc>().changeIndex(index);
                                if (Global.type == "user") {
                                  AppRoutes.push(
                                      context, CareerClusterScreen());
                                } else {
                                  AppRoutes.push(context, JobBoardsScreen());
                                }
                              },
                              index: 2,
                              selectedIndex: selectedIndex,
                              width: double.infinity,
                              img: Global.type == "user"
                                  ? MyImages.mail
                                  : MyImages.subscribe,
                              title: Global.type == "user"
                                  ? "Career Learning"
                                  : "Subscribe",
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: CustomAccDetails(
                              onTap: () {
                                index = 3;
                                context.read<IndexBloc>().changeIndex(index);
                                if (Global.type == "user") {
                                  AppRoutes.push(context, SaveJobsScreen());
                                } else {
                                  AppRoutes.push(context, AutomateMsgScreen());
                                }
                              },
                              index: 3,
                              selectedIndex: selectedIndex,
                              width: double.infinity,
                              img: Global.type == "user"
                                  ? MyImages.suitcase
                                  : MyImages.automateMsg,
                              title: Global.type == "user"
                                  ? "Saved Jobs"
                                  : "Automate Message",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      CustomAccDetails(
                        onTap: () {
                          index = 4;
                          context.read<IndexBloc>().changeIndex(index);
                          AppRoutes.push(context, SettingScreen());
                        },
                        index: 4,
                        selectedIndex: selectedIndex,
                        width: double.infinity,
                        img: MyImages.settings,
                        title: "Settings",
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

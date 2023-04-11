// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/search_pages/search_jobs_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/notification_pages/interviews_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/assigned_company_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';

import '../../../bloc/global_cubit/global_state.dart';
import '../home_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List<Widget> pages = [
    Global.type == "user" ? const SearchJobsScreen() : const AssignCompany(),
    const InterviewScreen(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var bottomBloc = context.read<GlobalCubit>();
    return BlocBuilder<GlobalCubit, InitialState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 72,
            decoration: BoxDecoration(
              color: MyColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildColumn(
                  onTap: () {
                    bottomBloc.setSelectedScreen(false);
                    bottomBloc.getIndex(0);
                  },
                  index: 0,
                  selectedIndex: bottomBloc.currentIndex,
                  image: MyImages.searchGrey,
                ),
                buildColumn(
                  onTap: () {
                    bottomBloc.setSelectedScreen(false);
                    bottomBloc.getIndex(1);
                  },
                  index: 1,
                  selectedIndex: bottomBloc.currentIndex,
                  image: MyImages.notification,
                ),
                buildColumn(
                  onTap: () {
                    bottomBloc.setSelectedScreen(false);
                    bottomBloc.getIndex(2);
                  },
                  index: 2,
                  selectedIndex: bottomBloc.currentIndex,
                  image: MyImages.user,
                ),
              ],
            ),
          ),
          body: bottomBloc.selectScreen
              ? bottomBloc.screenNameVal
              : pages[bottomBloc.currentIndex],
        );
      },
    );
  }

  Widget buildColumn(
      {int? index, int? selectedIndex, String? image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == selectedIndex
              ? Container(
                  height: 5,
                  width: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.blue),
                )
              : SizedBox(),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index == selectedIndex
                          ? MyColors.lightBlue.withOpacity(.20)
                          : MyColors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      image.toString(),
                      color: index == selectedIndex
                          ? MyColors.blue
                          : MyColors.grey,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

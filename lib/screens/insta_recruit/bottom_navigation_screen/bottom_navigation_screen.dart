// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/provider/bottom_provider.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/notification_pages/interviews_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/assigned_company_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Widget> pages = [
    AssignCompany(),
    InterviewScreen(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomProvider>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
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
                  value.setSelectedScreen(false);
                  value.getIndex(0);
                },
                index: 0,
                selectedIndex: value.currentIndex,
                image: MyImages.searchGrey,
              ),
              buildColumn(
                onTap: () {
                  value.setSelectedScreen(false);
                  value.getIndex(1);
                },
                index: 1,
                selectedIndex: value.currentIndex,
                image: MyImages.notification,
              ),
              buildColumn(
                onTap: () {
                  value.setSelectedScreen(false);
                  value.getIndex(2);
                },
                index: 2,
                selectedIndex: value.currentIndex,
                image: MyImages.user,
              ),
            ],
          ),
        ),
        body: value.selectScreen
            ? value.screenNameVal
            : pages[value.currentIndex],
      ),
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

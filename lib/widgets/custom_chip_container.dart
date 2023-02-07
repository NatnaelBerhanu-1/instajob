// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: MyColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildColumn(
            onTap: () {
              selectedIndex = 1;
              setState(() {});
            },
            index: 1,
            selectedIndex: selectedIndex,
            image: MyImages.searchGrey,
          ),
          buildColumn(
            onTap: () {
              selectedIndex = 2;
              setState(() {});
            },
            index: 2,
            selectedIndex: selectedIndex,
            image: MyImages.notification,
          ),
          buildColumn(
            onTap: () {
              selectedIndex = 3;
              setState(() {});
            },
            index: 3,
            selectedIndex: selectedIndex,
            image: MyImages.user,
          ),
        ],
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

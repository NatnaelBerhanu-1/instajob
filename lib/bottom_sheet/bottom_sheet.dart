// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';

leaveSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: SizedBox(
            height: 500,
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: MyColors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                ),
                Image.asset(MyImages.resume),
                // Column(),
              ],
            ),
          ),
        );
      });
}

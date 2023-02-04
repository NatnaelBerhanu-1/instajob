// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_images.dart';

class InterviewTile extends StatelessWidget {
  const InterviewTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grey.withOpacity(.30), width: 1.2),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.10),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(2, 3))
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 10, top: 11, left: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColors.transparent,
                      radius: 22,
                      backgroundImage: AssetImage(MyImages.google),
                    ),
                    Positioned(
                        bottom: 5,
                        left: 67,
                        child: Container(
                          padding: EdgeInsets.all(3.5),
                          decoration: BoxDecoration(
                              color: MyColors.blue, shape: BoxShape.circle),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 13,
                            color: MyColors.blue,
                          ),
                        )),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCommonText(
                      text: "Teresa Williams",
                      fontWeight: FontWeight.w500,
                    ),
                    CustomCommonText(
                      text: "Software engineer",
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ],
                ),
                Spacer(),
                CustomCommonText(
                  text: "Today",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: CustomButton(
                      borderColor: MyColors.red,
                      borderRadius: BorderRadius.circular(20),
                      title: "Cancel",
                      fontColor: MyColors.red,
                    )),
                SizedBox(width: 10),
                Expanded(
                    flex: 2,
                    child: CustomButton(
                      bgColor: MyColors.blue,
                      borderRadius: BorderRadius.circular(20),
                      title: "Interview Now",
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

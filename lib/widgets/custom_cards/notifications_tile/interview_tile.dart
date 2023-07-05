// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/call_screen.dart';
import 'package:insta_job/screens/insta_recruit/recording_screens/transcription_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../utils/my_colors.dart';

class InterviewTile extends StatelessWidget {
  final bool isRecording;
  const InterviewTile({Key? key, this.isRecording = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.lightgrey, width: 1.2),
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
                      // backgroundColor: MyColors.transparent,
                      radius: 20,
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
                    CommonText(
                      text: "Teresa Williams",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    CommonText(
                      text: "Software engineer",
                      fontWeight: FontWeight.w400,
                      fontColor: MyColors.grey,
                      fontSize: 12,
                    ),
                  ],
                ),
                Spacer(),
                CommonText(
                  text: "Today",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  fontColor: MyColors.grey,
                ),
              ],
            ),
            SizedBox(height: 5),
            isRecording
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: CustomButton(
                      height: MediaQuery.of(context).size.height * 0.048,
                      bgColor: MyColors.blue,
                      borderRadius: BorderRadius.circular(20),
                      title: "Recordings",
                      onTap: () {
                        AppRoutes.push(context, TranscriptionScreen());
                      },
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CustomButton(
                            height: MediaQuery.of(context).size.height * 0.048,
                            borderColor: MyColors.lightRed,
                            bgColor: MyColors.white,
                            borderRadius: BorderRadius.circular(20),
                            title: "Cancel",
                            fontColor: MyColors.lightRed,
                          )),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: CustomButton(
                            height: MediaQuery.of(context).size.height * 0.048,
                            bgColor: MyColors.blue,
                            borderRadius: BorderRadius.circular(20),
                            title: "Interview Now",
                            onTap: () {
                              AppRoutes.push(context, CallScreen());
                            },
                          )),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

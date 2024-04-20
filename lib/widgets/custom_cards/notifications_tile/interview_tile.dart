// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:insta_job/screens/call_screen.dart';
import 'package:insta_job/screens/insta_recruit/recording_screens/transcription_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../utils/my_colors.dart';

class InterviewTile extends StatefulWidget {
  final bool isRecording;

  const InterviewTile({
    Key? key,
    this.isRecording = false,
  }) : super(key: key);

  @override
  State<InterviewTile> createState() => _InterviewTileState();
}

class _InterviewTileState extends State<InterviewTile> {
  Timer? _timer;

  late Duration countdownDuration;
  late String buttonText;
  bool interviewTimeReached = false;

  @override
  void initState() {
    super.initState();
    var datetime = DateTime.now();
    var datetime2 =
        // DateTime.now().add(Duration(hours: 3, minutes: 20, seconds: 18));
        DateTime.now().add(Duration(hours: 0, minutes: 0, seconds: 3));
    countdownDuration = datetime2.difference(datetime);
    buttonText = '--h | -- mins | --s';
    // Start the countdown
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownDuration.inSeconds > 1) {
          countdownDuration -= Duration(seconds: 1);
          buttonText = formatDuration(countdownDuration);
        } else {
          // Countdown has reached zero, change button text
          buttonText = 'Interview Now';
          interviewTimeReached = true;
          _timer?.cancel();
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    // Format the duration as "Xh | Ym | Zs"
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    return '${hours}h | ${minutes} mins | ${seconds}s';
  }

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
            const EdgeInsets.only(right: 10, top: 15, left: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  // backgroundColor: MyColors.transparent,
                  radius: 20,
                ),
                // Positioned(
                //     bottom: 5,
                //     left: 67,
                //     child: Container(
                //       padding: EdgeInsets.all(3.5),
                //       decoration: BoxDecoration(
                //           color: MyColors.blue, shape: BoxShape.circle),
                //       child: Icon(
                //         Icons.camera_alt_outlined,
                //         size: 13,
                //         color: MyColors.blue,
                //       ),
                //     )),
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
            SizedBox(height: 10),
            widget.isRecording
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
                            borderColor: MyColors.darkRed,
                            bgColor: MyColors.white,
                            borderRadius: BorderRadius.circular(20),
                            title: "Cancel",
                            fontColor: MyColors.darkRed,
                          )),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: CustomButton(
                            height: MediaQuery.of(context).size.height * 0.048,
                            bgColor: interviewTimeReached
                                ? MyColors.blue
                                : MyColors.grey,
                            borderRadius: BorderRadius.circular(20),
                            title: buttonText,
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

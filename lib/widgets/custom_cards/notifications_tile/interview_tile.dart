// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/interview_model.dart';
import 'package:insta_job/network/end_points.dart';

import 'package:insta_job/screens/call_screen.dart';
import 'package:insta_job/screens/insta_recruit/recording_screens/transcription_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:intl/intl.dart';

import '../../../utils/my_colors.dart';

class InterviewTile extends StatefulWidget {
  final bool isRecording;
  final InterviewModel interviewModel;

  const InterviewTile({Key? key, this.isRecording = false, required this.interviewModel}) : super(key: key);

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
        widget.interviewModel.time.toDate();
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

    return '${hours}h | $minutes mins | ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.lightgrey, width: 1.2),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.10), spreadRadius: 2, blurRadius: 4, offset: Offset(2, 3)),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(right: 12, top: 15, left: 12, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  // backgroundColor: MyColors.transparent,
                  backgroundImage: NetworkImage(
                      "${EndPoint.imageBaseUrl}/${Global.userModel?.type == "user" ? widget.interviewModel.recruiter?.uploadPhoto : widget.interviewModel.user?.uploadPhoto}"),
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
                      text: Global.userModel?.type == 'user'
                          ? widget.interviewModel.recruiter?.name
                          : widget.interviewModel.user?.name,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    CommonText(
                      text: widget.interviewModel.job?.designation,
                      fontWeight: FontWeight.w400,
                      fontColor: MyColors.grey,
                      fontSize: 12,
                    ),
                  ],
                ),
                Spacer(),
                CommonText(
                  text: getInterviewDay(),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  fontColor: MyColors.grey,
                ),
              ],
            ),
            SizedBox(height: 16),
            widget.isRecording
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: CustomButton(
                      height: MediaQuery.of(context).size.height * 0.042,
                      bgColor: MyColors.blue,
                      borderRadius: BorderRadius.circular(20),
                      title: "Recordings",
                      onTap: () {
                        AppRoutes.push(context, TranscriptionScreen());
                      },
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          fontSize: 14,
                          height: MediaQuery.of(context).size.height * 0.042,
                          borderColor: MyColors.darkRed,
                          bgColor: MyColors.white,
                          borderRadius: BorderRadius.circular(20),
                          title: "Cancel",
                          fontColor: MyColors.darkRed,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomButton(
                          fontSize: 14,
                          height: MediaQuery.of(context).size.height * 0.042,
                          bgColor: interviewTimeReached ? MyColors.blue : MyColors.grey,
                          borderRadius: BorderRadius.circular(20),
                          title: buttonText,
                          onTap: () {
                            var interviewModel = widget.interviewModel;
                            int userId;
                            int otherUserId;
                            if (Global.userModel?.type == "user") {
                              userId = interviewModel.user?.id ?? 0;
                              otherUserId = interviewModel.recruiter?.id ?? 1;
                            } else {
                              userId = interviewModel.recruiter?.id ?? 1;
                              otherUserId = interviewModel.user?.id ?? 0;
                            }
                            AppRoutes.push(context, CallScreen(currentId: userId, otherUserId: otherUserId));
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  getInterviewDay() {
    String day = DateFormat(DateFormat.YEAR_MONTH_DAY).format(widget.interviewModel.time.toDate());

    var diff = DateTime.now().millisecondsSinceEpoch - widget.interviewModel.time.millisecondsSinceEpoch;
    var days = Duration(milliseconds: diff).inDays;

    if (days == 0) {
      day = "Today";
    } else if (days == 1) {
      day = "Tomorrow";
    }
    return day;
  }
}

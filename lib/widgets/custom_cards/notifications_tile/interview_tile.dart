// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/cancel_interview_schedule_cubit/cancel_interview_schedule_cubit.dart';
import 'package:insta_job/bloc/cancel_interview_schedule_cubit/cancel_interview_schedule_state.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_cubit.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/model/interview_model.dart';
import 'package:insta_job/network/end_points.dart';

import 'package:insta_job/screens/call_screen.dart';
import 'package:insta_job/screens/insta_job_user/interview_recordings/interview_recordings_screen.dart';
import 'package:insta_job/screens/insta_recruit/recording_screens/transcription_screen.dart';
import 'package:insta_job/utils/agora_credentials.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:intl/intl.dart';

import '../../../utils/my_colors.dart';

class InterviewTile extends StatefulWidget {
  final bool isRecording;
  final InterviewModel interviewModel;
  final List<QueryDocumentSnapshot<Object?>> chats;

  const InterviewTile({
    Key? key,
    this.isRecording = false,
    required this.interviewModel,
    required this.chats,
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
    var recordingStr = widget.interviewModel.callRecording;
    recordingStr ??= "";
    var hasRecording = widget.isRecording && recordingStr.isNotEmpty;
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
                      bgColor: hasRecording ? MyColors.blue : MyColors.grey,
                      borderRadius: BorderRadius.circular(20),
                      title: "Recordings",
                      onTap: hasRecording ? () {
                        //This is repeated from the onTap, of the chat screen navigation. #todo: refactor
                        // TODO: //REVISIT the default values when null (e.g. userId, otherUserId, userFirebaseId, otherUserFirebaseId, etc.)
                        var interviewModel = widget.interviewModel;
                        String userFirebaseId =
                            interviewModel.user?.firebaseId ?? "";
                        String otherUserFirebaseId =
                            interviewModel.recruiter?.firebaseId ?? "";
                        String gpFound =
                            "${otherUserFirebaseId}_$userFirebaseId";

                        int userId;
                        int otherUserId;
                        bool isUser = Global.userModel?.type == "user";
                        if (isUser) {
                          userId = interviewModel.user?.id ?? 0;
                          otherUserId = interviewModel.recruiter?.id ?? 1;
                        } else {
                          userId = interviewModel.recruiter?.id ?? 1;
                          otherUserId = interviewModel.user?.id ?? 0;
                        }

                        debugPrint("LOG gpFound $gpFound");
                        //TODO: revisit the ChatModel here
                        ChatModel model = ChatModel(
                          //selfId is always recruiter
                          gp: gpFound,
                          oppId: userFirebaseId,
                          selfId: otherUserFirebaseId,
                          oppName: interviewModel.user?.name,
                          oppProfilePic:
                              "${EndPoint.imageBaseUrl}interviewModel.user?.uploadPhoto",
                          selfName: interviewModel.recruiter?.name,
                          selfProfilePic:
                              "${EndPoint.imageBaseUrl}interviewModel.recruiter?.uploadPhoto",
                          userId: userId.toString(),
                        );
                        AppRoutes.push(context, InterviewRecordingsScreen(chatModel: model, interviewModel: widget.interviewModel));
                      } : null,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: BlocConsumer<CancelInterviewScheduleCubit, CancelInterviewScheduleState>(
                            builder: (context, state) {
                            return CustomButton(
                              fontSize: 14,
                              height: MediaQuery.of(context).size.height * 0.042,
                              borderColor: MyColors.darkRed,
                              bgColor: MyColors.white,
                              borderRadius: BorderRadius.circular(20),
                              title: "Cancel",
                              loading: state is CancelInterviewScheduleLoading && state.callId == widget.interviewModel.id.toString(),
                              loadingIndicatorColor: MyColors.black,
                              loadingIndicatorHeight: 22,
                              loadingIndicatorWidth: 22,
                              fontColor: MyColors.darkRed,
                              onTap: () {
                                buildDialog(
                                  context,
                                  CustomDialog(
                                    desc1: "You want to cancel this interview",
                                    okOnTap: () async {
                                      Navigator.of(context)
                                          .pop(); //revisit, double check that it's ok to pop first and call other items below(whether everything gets executed, whether to remote the setState etc/ consider dispose method too)
                                      context.read<CancelInterviewScheduleCubit>().cancelInterviewSchedule(callId: widget.interviewModel.id.toString(), statusCall: "cancel");
                                    },
                                    cancelOnTap: () {
                                      Navigator.pop(context);
                                    },
                                    headerImagePath: MyImages.delete,
                                  ));
                              },
                            );
                          }, 
                          listener: (context, state) { 
                            if (state is CancelInterviewScheduleSuccess) {
                              context.read<InterviewScheduleCubit>().getInterviewSchedules(Global.userModel!.id.toString());
                            } else if (state is CancelInterviewScheduleErrorState) {
                              showToast(state.message);
                            }
                          },
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
                            String userFirebaseId =
                                interviewModel.user?.firebaseId ?? "";
                            String otherUserFirebaseId =
                                interviewModel.recruiter?.firebaseId ?? "";
                            String gpFound =
                                "${otherUserFirebaseId}_$userFirebaseId";

                            int userId;
                            int otherUserId;
                            bool isUser = Global.userModel?.type == "user";
                            if (isUser) {
                              userId = interviewModel.user?.id ?? 0;
                              otherUserId = interviewModel.recruiter?.id ?? 1;
                            } else {
                              userId = interviewModel.recruiter?.id ?? 1;
                              otherUserId = interviewModel.user?.id ?? 0;
                            }

                            debugPrint("LOG gpFound $gpFound");
                            //TODO: revisit the ChatModel here
                            ChatModel model = ChatModel(
                              //selfId is always recruiter
                              gp: gpFound,
                              oppId: userFirebaseId,
                              selfId: otherUserFirebaseId,
                              oppName: interviewModel.user?.name,
                              oppProfilePic:
                                  "${EndPoint.imageBaseUrl}interviewModel.user?.uploadPhoto",
                              selfName: interviewModel.recruiter?.name,
                              selfProfilePic:
                                  "${EndPoint.imageBaseUrl}interviewModel.recruiter?.uploadPhoto",
                              userId: userId.toString(),
                            );
                            AppRoutes.push(
                                context,
                                CallScreen(
                                  // channelName: AgoraCredentials.CHANNEL_ID,
                                  // token: AgoraCredentials.TOKEN,
                                  channelName: widget.interviewModel.channelName ?? "",
                                  token: widget.interviewModel.token ?? "",
                                  chatModel: model,
                                  interviewModel: widget.interviewModel,
                                ));
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

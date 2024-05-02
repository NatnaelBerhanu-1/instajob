// ignore_for_file: prefer_const_constructors

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_job/bloc/agora_bloc/agora_cubit.dart';
import 'package:insta_job/bloc/agora_bloc/agora_state.dart';
import 'package:insta_job/bottom_sheet/overview_bottom_sheet.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/screens/chat_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';

class CallScreen extends StatefulWidget {
  int currentId;
  int otherUserId;
  ChatModel chatModel;
  CallScreen(
      {Key? key,
      required this.currentId,
      required this.otherUserId,
      required this.chatModel})
      : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  initAgora() async {
    // await context.read<AgoraBloc>().initAgora();
  }

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  bool videoEnabled = true;
  bool audioEnabled = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var isUser = Global.userModel?.type == "user";
    debugPrint("screen width $screenWidth");
    debugPrint("screen height $screenHeight");
    return PopScope(
      // canPop: false,
      child: Scaffold(
        backgroundColor: isUser ? MyColors.grey : MyColors.lightBlack,
        body: SafeArea(
          child: Stack(
            children: [
              if (!isUser)
                Positioned(
                  bottom: 40,
                  left: 28,
                  right: 28,
                  child: SizedBox(
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              audioEnabled = !audioEnabled;
                            });
                          },
                          child: SvgPicture.asset(
                            audioEnabled
                                ? MyImages.recruiterMicOpen
                                : MyImages.recruiterMicClosed,
                            height: 48,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              videoEnabled = !videoEnabled;
                            });
                          },
                          child: SvgPicture.asset(
                            videoEnabled
                                ? MyImages.recruiterVideoOpen
                                : MyImages.recruiterVideoClosed,
                            height: 48,
                          ),
                        ),
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: FloatingActionButton(
                            backgroundColor: MyColors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.call_end),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            AppRoutes.push(
                              context,
                              ChatScreen(
                                chatModel: widget.chatModel,
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            MyImages.recruiterMessageBtn,
                            height: 48,
                          ),
                        ),
                        SvgPicture.asset(
                          MyImages.recruiterQuestionsBtn,
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                ),
              if (isUser)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          MyImages.subtraction44A,
                          // MyImages.userBottomContainer,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
              if (isUser)
                Positioned(
                  bottom: screenHeight * 0.1,
                  left: screenWidth / 2 - screenWidth * 0.072,
                  // left: screenWidth / 2 - 28,
                  child: Center(
                    child: FloatingActionButton(
                      backgroundColor: MyColors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.call_end),
                    ),
                  ),
                ),
              if (isUser)
                Positioned(
                  bottom: 40,
                  left: 1.1 * screenWidth / 6,
                  child: InkWell(
                    onTap: () {
                      AppRoutes.push(
                        context,
                        ChatScreen(
                          chatModel: widget.chatModel,
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      MyImages.userMessageBtn,
                      height: 35,
                    ),
                  ),
                ),
              if (isUser)
                Positioned(
                  bottom: 40,
                  left: 4.5 * screenWidth / 6,
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      MyImages.userMoreBtn,
                      height: 35,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Positioned(
                      bottom: 0,
                      left: 58,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: MyColors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Icon(Icons.camera_alt, color: MyColors.white),
                          )),
                    ),*/

class CustomCallButtons extends StatelessWidget {
  final IconData? image;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  const CustomCallButtons({
    super.key,
    this.image,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? MyColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(image ?? Icons.class_outlined, color: iconColor),
        ),
      ),
    );
  }
}

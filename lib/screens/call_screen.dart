// ignore_for_file: prefer_const_constructors

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/agora_bloc/agora_cubit.dart';
import 'package:insta_job/bloc/agora_bloc/agora_state.dart';
import 'package:insta_job/bottom_sheet/overview_bottom_sheet.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';

class CallScreen extends StatefulWidget {
  int currentId;
  int otherUserId;
  CallScreen({Key? key, required this.currentId, required this.otherUserId}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  initAgora() async {
    await context.read<AgoraBloc>().initAgora(currentId: widget.currentId, otherUserId: widget.otherUserId,);
  }

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: MyColors.grey,
        body: SafeArea(
            child: BlocConsumer<AgoraBloc, AgoraInitial>(listener: (c, state) {
          if (state is OnUserOffline) {
            context.read<AgoraBloc>().releaseEngine();
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          var agoraEngine = context.read<AgoraBloc>();
          return Stack(
            children: [
              agoraEngine.engine != null && agoraEngine.isVideoEnabled
                  ? AgoraVideoView(
                      controller: VideoViewController(
                          rtcEngine: agoraEngine.engine!,
                          canvas: VideoCanvas(uid: 0)))
                  : SizedBox(),
              /*     Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 150,
                            width: 150,
                            color: MyColors.white,
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: MyColors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),*/
              // Spacer(),
              agoraEngine.remoteVideo(otherUserId: widget.otherUserId,),
              
              Global.userModel?.type == "user" ? 
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  color: MyColors.white.withOpacity(.90),
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                          child: CustomCallButtons(
                        backgroundColor: MyColors.blue,
                        iconColor: MyColors.white,
                        image:  Icons.more_horiz_outlined,
                        onTap: () {
                          
                        },
                      )),
                      Expanded(
                        child: FloatingActionButton(
                          backgroundColor: MyColors.red,
                          onPressed: () {
                            agoraEngine.releaseEngine();
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.call_end),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: CustomCallButtons(
                        backgroundColor: MyColors.blue,
                        iconColor: MyColors.white,
                        image:  Icons.more_vert,
                        onTap: () {
                        },
                      )),
                    ],
                  ),
                ),
              )
              : Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  color: MyColors.black.withOpacity(.90),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomCallButtons(
                          onTap: () async {
                            // await agoraEngine.engine?.muteLocalAudioStream(true);
                            await agoraEngine.toggleAudio();
                            setState(() {
                              
                            });
                          },
                          image: agoraEngine.isAudioEnabled ? Icons.mic : Icons.mic_off,
                        )),
                        Expanded(
                            child: CustomCallButtons(
                              onTap: () async {
                                await agoraEngine.toggleVideo();
                                setState(() {
                                  
                                });
                              },
                          // image: Icons.videocam_outlined,
                          image: agoraEngine.isVideoEnabled ? Icons.videocam_outlined : Icons.videocam_off_outlined,
                        )),
                        Expanded(
                          child: FloatingActionButton(
                            backgroundColor: MyColors.red,
                            onPressed: () {
                              agoraEngine.releaseEngine();
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.call_end),
                          ),
                        ),
                        Expanded(child: CustomCallButtons(image: Icons.chat)),
                        Expanded(
                            child: CustomCallButtons(
                          image:  Icons.paste,
                          onTap: () {
                            overviewBottomSheet(context);
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        })),
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

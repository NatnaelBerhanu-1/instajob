// ignore_for_file: prefer_const_constructors

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/agora_bloc/agora_cubit.dart';
import 'package:insta_job/bloc/agora_bloc/agora_state.dart';
import 'package:insta_job/bottom_sheet/overview_bottom_sheet.dart';
import 'package:insta_job/utils/my_colors.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  initAgora() async {
    await context.read<AgoraBloc>().initAgora();
  }

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            agoraEngine.engine != null
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
            agoraEngine.remoteVideo(),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: MyColors.black.withOpacity(.80),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomCallButtons(
                        onTap: () async {
                          // await agoraEngine.engine?.muteLocalAudioStream(true);
                        },
                        image: Icons.mic,
                      )),
                      Expanded(
                          child: CustomCallButtons(
                        image: Icons.videocam_outlined,
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
                        image: Icons.paste,
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
  const CustomCallButtons({
    super.key,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColors.lightgrey.withOpacity(.50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(image ?? Icons.class_outlined),
        ),
      ),
    );
  }
}

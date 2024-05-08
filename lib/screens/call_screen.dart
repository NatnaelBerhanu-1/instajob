// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_job/bloc/agora_bloc/agora_cubit.dart';
import 'package:insta_job/bloc/agora_bloc/agora_state.dart';
import 'package:insta_job/bottom_sheet/overview_bottom_sheet.dart';
import 'package:insta_job/globals.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:insta_job/model/agora_user.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/screens/chat_screen.dart';
import 'package:insta_job/screens/prejoining_dialog.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  final String token;
  final String channelName;
  ChatModel chatModel;
  CallScreen(
      {Key? key,
      required this.token, 
      required this.channelName,
      required this.chatModel})
      : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final RtcEngine _agoraEngine;
  late final _users = <AgoraUser>{};
  late double _viewAspectRatio;
  int? _currentUid;

  String appId = '181c4f5ccf6a49bda4f5bbcf36bc3f92';
  String channelId = 'instaJob_channel';
  String token =
      "007eJxTYGDe3OHjYc1xRHOH+3rmyusufxfGqFiz95TfPu7qGT97R6QCg6WFeYqpRZKBsYmZkUlyclqSoWmKUWpimoGlgZmpZbLlffvtqQ2BjAxydj6MjAwQCOILMGTmFZckeuUnxSdnJOblpeYwMAAAIoAh0A==";


  @override
  void initState() {
    _initialize();
    super.initState();
  }

  bool _isMicEnabled = false;
  bool _isCameraEnabled = false;
  bool _isJoining = false;

  void openSettings() {
    openAppSettings();
  }

  @override
  void dispose() {
    _users.clear();
    _disposeAgora();
    super.dispose();
  }

  Future<void> _disposeAgora() async {
    await _agoraEngine.leaveChannel();
    await _agoraEngine.destroy();
  }

  Future<void> _initialize() async {
    // Set aspect ratio for video according to platform
    if (kIsWeb) {
      _viewAspectRatio = 3 / 2;
    } else if (Platform.isAndroid || Platform.isIOS) {
      _viewAspectRatio = 2 / 3;
    } else {
      _viewAspectRatio = 3 / 2;
    }
    // Initialize microphone and camera
    setState(() {
      _isMicEnabled = false;
      _isCameraEnabled = false;
    });
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    final options = ChannelMediaOptions(
      publishLocalAudio: _isMicEnabled,
      publishLocalVideo: _isCameraEnabled,
    );
    await _agoraEngine.joinChannel(
      widget.token,
      widget.channelName,
      null,
      0,
      options,
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    // _agoraEngine = await RtcEngine.create(widget.appId);
    _agoraEngine = await RtcEngine.create(appId);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.orientationMode = VideoOutputOrientationMode.Adaptative;
    await _agoraEngine.setVideoEncoderConfiguration(configuration);
    await _agoraEngine.enableAudio();
    await _agoraEngine.enableVideo();
    await _agoraEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _agoraEngine.setClientRole(ClientRole.Broadcaster);
    await _agoraEngine.muteLocalAudioStream(_isMicEnabled);
    await _agoraEngine.muteLocalVideoStream(_isCameraEnabled);
  }

    void _addAgoraEventHandlers() => _agoraEngine.setEventHandler(
        RtcEngineEventHandler(
          error: (code) {
            final info = 'LOG::onError: $code';
            debugPrint(info);
          },
          joinChannelSuccess: (channel, uid, elapsed) {
            final info = 'LOG::onJoinChannel: $channel, uid: $uid';
            debugPrint(info);
            setState(() {
              _currentUid = uid;
              _users.add(
                AgoraUser(
                  uid: uid,
                  isAudioEnabled: _isMicEnabled,
                  isVideoEnabled: _isCameraEnabled,
                  view: const rtc_local_view.SurfaceView(),
                ),
              );
            });
          },
          firstLocalAudioFrame: (elapsed) {
            final info = 'LOG::firstLocalAudio: $elapsed';
            debugPrint(info);
            for (AgoraUser user in _users) {
              if (user.uid == _currentUid) {
                setState(() => user.isAudioEnabled = _isMicEnabled);
              }
            }
          },
          firstLocalVideoFrame: (width, height, elapsed) {
            debugPrint('LOG::firstLocalVideo');
            for (AgoraUser user in _users) {
              if (user.uid == _currentUid) {
                setState(
                  () => user
                    ..isVideoEnabled = _isCameraEnabled
                    ..view = const rtc_local_view.SurfaceView(
                      renderMode: VideoRenderMode.Hidden,
                    ),
                );
              }
            }
          },
          leaveChannel: (stats) {
            debugPrint('LOG::onLeaveChannel');
            setState(() => _users.clear());
          },
          userJoined: (uid, elapsed) {
            final info = 'LOG::userJoined: $uid';
            debugPrint(info);
            setState(
              () => _users.add(
                AgoraUser(
                  uid: uid,
                  view: rtc_remote_view.SurfaceView(
                    channelId: widget.channelName,
                    uid: uid,
                  ),
                ),
              ),
            );
          },
          userOffline: (uid, elapsed) {
            final info = 'LOG::userOffline: $uid';
            debugPrint(info);
            AgoraUser? userToRemove;
            for (AgoraUser user in _users) {
              if (user.uid == uid) {
                userToRemove = user;
              }
            }
            setState(() => _users.remove(userToRemove));
          },
          firstRemoteAudioFrame: (uid, elapsed) {
            final info = 'LOG::firstRemoteAudio: $uid';
            debugPrint(info);
            for (AgoraUser user in _users) {
              if (user.uid == uid) {
                setState(() => user.isAudioEnabled = true);
              }
            }
          },
          firstRemoteVideoFrame: (uid, width, height, elapsed) {
            final info = 'LOG::firstRemoteVideo: $uid ${width}x $height';
            debugPrint(info);
            for (AgoraUser user in _users) {
              if (user.uid == uid) {
                setState(
                  () => user
                    ..isVideoEnabled = true
                    ..view = rtc_remote_view.SurfaceView(
                      channelId: widget.channelName,
                      uid: uid,
                    ),
                );
              }
            }
          },
          remoteVideoStateChanged: (uid, state, reason, elapsed) {
            final info = 'LOG::remoteVideoStateChanged: $uid $state $reason';
            debugPrint(info);
            for (AgoraUser user in _users) {
              if (user.uid == uid) {
                setState(() =>
                    user.isVideoEnabled = state != VideoRemoteState.Stopped);
              }
            }
          },
          remoteAudioStateChanged: (uid, state, reason, elapsed) {
            final info = 'LOG::remoteAudioStateChanged: $uid $state $reason';
            debugPrint(info);
            for (AgoraUser user in _users) {
              if (user.uid == uid) {
                setState(() =>
                    user.isAudioEnabled = state != AudioRemoteState.Stopped);
              }
            }
          },
        ),
      );

  Future<void> _onCallEnd(BuildContext context) async {
    await _agoraEngine.leaveChannel();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _onToggleAudio() {
    setState(() {
      _isMicEnabled = !_isMicEnabled;
      for (AgoraUser user in _users) {
        if (user.uid == _currentUid) {
          user.isAudioEnabled = _isMicEnabled;
        }
      }
    });
    _agoraEngine.muteLocalAudioStream(!_isMicEnabled);
  }

  void _onToggleCamera() {
    setState(() {
      _isCameraEnabled = !_isCameraEnabled;
      for (AgoraUser user in _users) {
        if (user.uid == _currentUid) {
          setState(() => user.isVideoEnabled = _isCameraEnabled);
        }
      }
    });
    _agoraEngine.muteLocalVideoStream(!_isCameraEnabled);
  }

  void _onSwitchCamera() => _agoraEngine.switchCamera();

  List<int> _createLayout(int n) {
    int rows = (sqrt(n).ceil());
    int columns = (n / rows).ceil();

    List<int> layout = List<int>.filled(rows, columns);
    int remainingScreens = rows * columns - n;

    for (int i = 0; i < remainingScreens; i++) {
      layout[layout.length - 1 - i] -= 1;
    }

    return layout;
  }

  Future<bool> getMicPermissions() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final micPermission = await Permission.microphone.request();
      if (micPermission == PermissionStatus.granted) {
        // setState(() => _isMicEnabled = true);
        return true;
      } else {
        return false;
      }
    } else {
      // setState(() => _isMicEnabled = !_isMicEnabled);
      return false;
    }
  }

  Future<void> getCameraPermissions() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final cameraPermission = await Permission.camera.request();
      if (cameraPermission == PermissionStatus.granted) {
        setState(() => _isCameraEnabled = true);
      }
    } else {
      setState(() => _isCameraEnabled = !_isCameraEnabled);
    }
  }


  Future<void> getPermissions() async {
    await getMicPermissions();
    await getCameraPermissions();
  }

  // Future<void> _joinCall() async {
  //   setState(() => _isJoining = true);
  //   if (context.mounted) {
  //     Navigator.of(context).pop();
  //     await Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => VideoCallPage(
  //           appId: appId,
  //           token: widget.token,
  //           channelName: widget.channelName,
  //           isMicEnabled: _isMicEnabled,
  //           isVideoEnabled: _isCameraEnabled,
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var isUser = Global.userModel?.type == "user";
    debugPrint("screen width $screenWidth");
    debugPrint("screen height $screenHeight");
    debugPrint("now is Mic enabled $_isMicEnabled &&&&&&&& video camera enabled $_isCameraEnabled");
    return PopScope(
      // canPop: false,
      child: Scaffold(
        backgroundColor: isUser ? MyColors.grey : MyColors.lightBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          centerTitle: false,
          title: Row(
            children: [
              const Icon(
                Icons.meeting_room_rounded,
                color: Colors.white54,
              ),
              const SizedBox(width: 6.0),
              const Text(
                'Channel name: ',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16.0,
                ),
              ),
              Text(
                widget.channelName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.people_alt_rounded,
                    color: Colors.white54,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    _users.length.toString(),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      final isPortrait = orientation == Orientation.portrait;
                      if (_users.isEmpty) {
                        return const SizedBox();
                      }
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => setState(
                            () => _viewAspectRatio = isPortrait ? 2 / 3 : 3 / 2),
                      );
                      final layoutViews = _createLayout(_users.length);
                      return AgoraVideoLayout(
                        users: _users,
                        views: layoutViews,
                        viewAspectRatio: _viewAspectRatio,
                      );
                    },
                  ),
                ),
                Expanded(flex: 1, child: Container(),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: SizedBox(
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          // onTap: () {
                          //   if (_isMicEnabled) {
                          //     setState(() => _isMicEnabled = false);
                          //   } else {
                          //     getMicPermissions();
                          //   }
                          // },
                          // onTap: _onToggleAudio,
                          onTap: () async {
                            if (_isMicEnabled) {
                              setState(() => _isMicEnabled = false);
                              for (AgoraUser user in _users) {
                                if (user.uid == _currentUid) {
                                  user.isAudioEnabled = _isMicEnabled;
                                }
                              }
                            } else {
                              final res = await getMicPermissions();
                              if (res == true) {
                                setState(() => _isMicEnabled = true);
                                for (AgoraUser user in _users) {
                                  if (user.uid == _currentUid) {
                                    user.isAudioEnabled = _isMicEnabled;
                                  }
                                }
                              }
                            }
                          },
                          child: SvgPicture.asset(
                            _isMicEnabled
                                ? MyImages.recruiterMicOpen
                                : MyImages.recruiterMicClosed,
                            height: 48,
                          ),
                        ),
                        InkWell(
                          // onTap: () {
                          //  if (_isCameraEnabled) {
                          //    setState(() => _isCameraEnabled = false);
                          //  } else {
                          //   getCameraPermissions();
                          //  }
                          // },
                          // onTap: _onToggleCamera,
                          onTap: () async {
                            if (_isCameraEnabled) {
                              setState(() => _isCameraEnabled = false);
                              for (AgoraUser user in _users) {
                                if (user.uid == _currentUid) {
                                  user.isVideoEnabled = _isCameraEnabled;
                                }
                              }
                            } else {
                              final res = await getMicPermissions();
                              if (res == true) {
                                setState(() => _isCameraEnabled = true);
                                for (AgoraUser user in _users) {
                                  if (user.uid == _currentUid) {
                                    user.isVideoEnabled = _isCameraEnabled;
                                  }
                                }
                              }
                            }
                          },
                          child: SvgPicture.asset(
                            _isCameraEnabled
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
                            onPressed: () async {
                              // Navigator.of(context).pop();
                              _onCallEnd(context);
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

class AgoraVideoLayout extends StatelessWidget {
  const AgoraVideoLayout({
    super.key,
    required Set<AgoraUser> users,
    required List<int> views,
    required double viewAspectRatio,
  })  : _users = users,
        _views = views,
        _viewAspectRatio = viewAspectRatio;

  final Set<AgoraUser> _users;
  final List<int> _views;
  final double _viewAspectRatio;

  @override
  Widget build(BuildContext context) {
    int totalCount = _views.reduce((value, element) => value + element);
    int rows = _views.length;
    int columns = _views.reduce(max);

    List<Widget> rowsList = [];
    for (int i = 0; i < rows; i++) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < columns; j++) {
        int index = i * columns + j;
        if (index < totalCount) {
          rowChildren.add(
            AgoraVideoView(
              user: _users.elementAt(index),
              viewAspectRatio: _viewAspectRatio,
            ),
          );
        } else {
          rowChildren.add(
            const SizedBox.shrink(),
          );
        }
      }
      rowsList.add(
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowChildren,
          ),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowsList,
    );
  }
}

class AgoraVideoView extends StatelessWidget {
  const AgoraVideoView({
    super.key,
    required double viewAspectRatio,
    required AgoraUser user,
  })  : _viewAspectRatio = viewAspectRatio,
        _user = user;

  final double _viewAspectRatio;
  final AgoraUser _user;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: AspectRatio(
          aspectRatio: _viewAspectRatio,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _user.isAudioEnabled ?? false ? Colors.blue : Colors.red,
                width: 2.0,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    maxRadius: 18,
                    child: Icon(
                      Icons.person,
                      color: Colors.grey.shade600,
                      size: 24.0,
                    ),
                  ),
                ),
                if (_user.isVideoEnabled ?? false)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8 - 2),
                    child: _user.view,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
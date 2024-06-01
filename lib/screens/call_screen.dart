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
import 'package:insta_job/bloc/interview_recording_cubit/interview_recording_cubit.dart';
import 'package:insta_job/bloc/interview_recording_cubit/interview_recording_state.dart';
import 'package:insta_job/bottom_sheet/overview_bottom_sheet.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:insta_job/model/agora_user.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/model/interview_model.dart';
import 'package:insta_job/screens/chat_screen.dart';
import 'package:insta_job/utils/agora_credentials.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  final String? token;
  final String channelName;
  ChatModel chatModel;
  InterviewModel interviewModel;
  CallScreen(
      {Key? key,
      required this.token, 
      required this.channelName,
      required this.chatModel, 
      required this.interviewModel})
      : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final RtcEngine _agoraEngine;
  var _users = <AgoraUser>{};
  late double _viewAspectRatio;
  int? _currentUid;



  @override
  void initState() {
    // context.read<InterviewRecordingCubit>().resetState();
    _isJoining = true;
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
    _agoraEngine = await RtcEngine.create(AgoraCredentials.APP_ID);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.orientationMode = VideoOutputOrientationMode.Adaptative;
    await _agoraEngine.setVideoEncoderConfiguration(configuration);
    await _agoraEngine.enableAudio();
    await _agoraEngine.enableVideo();
    await _agoraEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _agoraEngine.setClientRole(ClientRole.Broadcaster);
    await _agoraEngine.muteLocalAudioStream(!_isMicEnabled);
    await _agoraEngine.muteLocalVideoStream(!_isCameraEnabled);
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
            debugPrint("${_users.map((e) => "${e.uid}: ${e.uid != _currentUid}")}");
            // _users.removeWhere((element) => element.uid != _currentUid);
            //     debugPrint('Users[userJoined]: $_users, $_currentUid');
            //     _users.add(
            //     AgoraUser(
            //       uid: uid,
            //       view: rtc_remote_view.SurfaceView(
            //         channelId: widget.channelName,
            //         uid: uid,
            //       ),
            //     ),
            //   );
            _users = {
              AgoraUser(
                  uid: _currentUid!,
                  isAudioEnabled: _isMicEnabled,
                  isVideoEnabled: _isCameraEnabled,
                  view: const rtc_local_view.SurfaceView(),
                ),
                AgoraUser(
                  uid: uid,
                  view: rtc_remote_view.SurfaceView(
                    channelId: widget.channelName,
                    uid: uid,
                  ),
                )
            };
            setState(
              () {
              }
            );
            print("LOG:: users ${_users.map((e) => e.uid)}");
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

  Future<void> _onCallEnd(BuildContext context, {required String channelName, required int? interviewId}) async {
     if (context.read<InterviewRecordingCubit>().recordingStatus == RecordingStatus.recording) {
      context.read<InterviewRecordingCubit>().stopRecording(
        channelName: channelName,
        interviewId: interviewId,
      );
     }
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
        final check =await Permission.microphone.status;
        if (check == PermissionStatus.denied || check == PermissionStatus.permanentlyDenied) {
          if (mounted) {
            await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Permission Required"),
                content: Text("Please grant microphone permission to use this feature."),
                actions: <Widget>[
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text("Open Settings"),
                    onPressed: () async {
                      await openAppSettings(); // Opens app settings
                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
          }
        }
        return false;
      }
    } else {
      // setState(() => _isMicEnabled = !_isMicEnabled);
      return false;
    }
  }

  Future<bool> getCameraPermissions() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final cameraPermission = await Permission.camera.request();
      if (cameraPermission == PermissionStatus.granted) {
        // setState(() => _isCameraEnabled = true);
        return true;
      } else {
        final check =await Permission.microphone.status;
        if (check == PermissionStatus.denied || check == PermissionStatus.permanentlyDenied) {
          if (mounted) {
            await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Permission Required"),
                content: Text("Please grant microphone permission to use this feature."),
                actions: <Widget>[
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text("Open Settings"),
                    onPressed: () async {
                      await openAppSettings(); // Opens app settings
                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
          }
        }
        return false;
      }
    } else {
      // setState(() => _isCameraEnabled = !_isCameraEnabled);
      return false;
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
    debugPrint("LOGG channel name ${widget.channelName}");
    debugPrint("now is Mic enabled $_isMicEnabled &&&&&&&& video camera enabled $_isCameraEnabled");
    return PopScope(
      // canPop: false,
      child: Scaffold(
        // backgroundColor: isUser ? MyColors.grey : MyColors.lightBlack,
        backgroundColor: MyColors.lightBlack,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.black,
        //   surfaceTintColor: Colors.black,
        //   centerTitle: false,
        //   title: Row(
        //     children: [
        //       const Icon(
        //         Icons.meeting_room_rounded,
        //         color: Colors.white54,
        //       ),
        //       const SizedBox(width: 6.0),
        //       const Text(
        //         'Channel name: ',
        //         style: TextStyle(
        //           color: Colors.white54,
        //           fontSize: 16.0,
        //         ),
        //       ),
        //       Text(
        //         widget.channelName,
        //         style: const TextStyle(
        //           color: Colors.white,
        //           fontSize: 16.0,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 8.0),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           const Icon(
        //             Icons.people_alt_rounded,
        //             color: Colors.white54,
        //           ),
        //           const SizedBox(width: 6.0),
        //           Text(
        //             _users.length.toString(),
        //             style: const TextStyle(
        //               color: Colors.white54,
        //               fontSize: 16.0,
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    // final isPortrait = orientation == Orientation.portrait;
                    final isPortrait = true;
                    if (_users.isEmpty) {
                      return const SizedBox();
                    }
                    // WidgetsBinding.instance.addPostFrameCallback(
                    //   (_) => setState(
                    //       () => _viewAspectRatio = isPortrait ? 2 / 3 : 3 / 2),
                    // );
                    // final layoutViews = _createLayout(_users.length);
                    return AgoraVideoLayout(
                      users: _users,
                      // views: layoutViews,
                      views: [],
                      viewAspectRatio: _viewAspectRatio,
                      currentUserId: _currentUid,
                      onSwitchCamera: _onSwitchCamera,
                      chatModel: widget.chatModel,
                      channelName: widget.channelName,
                      interviewModel: widget.interviewModel,
                    );
                  },
                ),
              ),
              // Expanded(flex: 1, child: Container(),),
              // Text("HI"),
              // Container(width: 200,height: 20, color: Colors.red),
              SizedBox(height: 16),
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
                          await _agoraEngine.muteLocalAudioStream(!_isMicEnabled);
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
                            final res = await getCameraPermissions();
                            if (res == true) {
                              setState(() => _isCameraEnabled = true);
                              for (AgoraUser user in _users) {
                                if (user.uid == _currentUid) {
                                  user.isVideoEnabled = _isCameraEnabled;
                                }
                              }
                            }
                          }
                          await _agoraEngine.muteLocalVideoStream(!_isCameraEnabled);
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
                            _onCallEnd(context, channelName: widget.channelName, interviewId: widget.interviewModel.id);
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
                      InkWell(
                        onTap: () {
                          _onSwitchCamera();
                        },
                        child: SvgPicture.asset(
                          MyImages.recruiterQuestionsBtn,
                          height: 48,
                        ),
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
    required int? currentUserId, 
    required void Function() onSwitchCamera, 
    required ChatModel chatModel, 
    required String channelName, 
    required InterviewModel interviewModel,
  })  : _users = users,
        _views = views,
        _viewAspectRatio = viewAspectRatio,
        _currentUserId = currentUserId,
        _onSwitchCamera = onSwitchCamera,
        _chatModel = chatModel,
        _channelName = channelName,
        _interviewModel = interviewModel;

  final Set<AgoraUser> _users;
  final List<int> _views;
  final double _viewAspectRatio;
  final int? _currentUserId;
  final void Function() _onSwitchCamera;
  final ChatModel _chatModel;
  final String _channelName;
  final InterviewModel _interviewModel;

  @override
  Widget build(BuildContext context) {
    // int totalCount = _views.reduce((value, element) => value + element);
    // int rows = _views.length;
    // int columns = _views.reduce(max);

    // List<Widget> rowsList = [];
    // for (int i = 0; i < rows; i++) {
    //   List<Widget> rowChildren = [];
    //   for (int j = 0; j < columns; j++) {
    //     int index = i * columns + j;
    //     if (index < totalCount) {
    //       rowChildren.add(
    //         AgoraVideoView(
    //           user: _users.elementAt(index),
    //           viewAspectRatio: _viewAspectRatio,
    //         ),
    //       );
    //     } else {
    //       rowChildren.add(
    //         const SizedBox.shrink(),
    //       );
    //     }
    //   }
    //   // var item = rowChildren;
    //   // rowsList.add(
    //   //   Flexible(
    //   //     child: Row(
    //   //       mainAxisAlignment: MainAxisAlignment.center,
    //   //       children: rowChildren,
    //   //     ),
    //   //   ),
    //   // );
    //   rowsList.add(
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: rowChildren,
    //     ),
    //   );
    // }
    // // return Container(width: 300, height: 400, color: Colors.amber);
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: rowsList,
    // );

    var res = [];
    var usersLen = _users.length;

    // for (int i = 0; i < _users.length; i++) {
    //   res.add(Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10),
    //     child: AgoraVideoView(
    //       user: _users.elementAt(i),
    //       viewAspectRatio: _viewAspectRatio,
    //     ),
    //   ));
    // }
    // return Wrap(children: [
    //   // res.isNotEmpty ? res[0] : Text("empty"),
    //   // res.isNotEmpty ? res[0] : Text("empty"),
    //   ...res,
    // ],);
    var fallBackAgoraUser = AgoraUser(uid: 100000321, isAudioEnabled: false, isVideoEnabled: false, name: "", view: null); //just default agora user, to avoid bad state 
    var currAgoraUser = getCurrentAgoraUser(_users, _currentUserId, fallBackAgoraUser);
    var otherAgoraUser = getOtherAgoraUser(_users, _currentUserId, fallBackAgoraUser);
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          child: AgoraVideoView(
            user: _users.length > 1 ? otherAgoraUser: currAgoraUser,
            viewAspectRatio: _viewAspectRatio,
            onSwitchCamera: _users.length > 1 ? null: _onSwitchCamera,
            users: _users,
            isSmallerScreen: false,
            chatModel: _chatModel,
            channelName: _channelName,
            interviewModel: _interviewModel,
          ),
        ),
        if (getOtherAgoraUsers(_users, _currentUserId).isNotEmpty)
        Positioned(
          top: 20,
          right: 20,
          child: AgoraVideoView(
            user: currAgoraUser,
            viewAspectRatio: _viewAspectRatio,
            height: 200,
            width: 200,
            onSwitchCamera: _onSwitchCamera,
            users: _users,
            isSmallerScreen: true,
            chatModel: _chatModel,
            channelName: _channelName,
            interviewModel: _interviewModel,
          ),
        ),
      ],
    );    
  }

  static AgoraUser getCurrentAgoraUser(Set<AgoraUser> users, int? currentUserId, AgoraUser fallBackAgoraUser) {
    var filteredAgoraUsersList = users.where((element) => element.uid == currentUserId).toList();
    if (filteredAgoraUsersList.isNotEmpty) {
      return filteredAgoraUsersList[0];
    }
    // return null;
    return fallBackAgoraUser;
  }

  static List<AgoraUser> getOtherAgoraUsers(Set<AgoraUser> users, int? currentUserId) {
    var filteredAgoraUsersList = users.where((element) => element.uid != currentUserId).toList();
    return filteredAgoraUsersList;
  }

  static AgoraUser getOtherAgoraUser(Set<AgoraUser> users, int? currentUserId, AgoraUser fallBackAgoraUser) {
    var filteredAgoraUsersList = getOtherAgoraUsers(users, currentUserId);
    if (filteredAgoraUsersList.isNotEmpty) {
      return filteredAgoraUsersList[0];
    }
    // return null;
    return fallBackAgoraUser;
  }
}

class AgoraVideoView extends StatelessWidget {
  const AgoraVideoView({
    super.key,
    required double viewAspectRatio,
    required AgoraUser user, 
    double? width, 
    double? height, 
    void Function()? onSwitchCamera, 
    required Set<AgoraUser> users, 
    required bool isSmallerScreen, 
    required ChatModel chatModel, 
    required String channelName, 
    required InterviewModel interviewModel,
  })  : _viewAspectRatio = viewAspectRatio,
        _user = user,
        _height = height,
        _width = width,
        _onSwitchCamera = onSwitchCamera,
        _users = users,
        _isSmallerScreen = isSmallerScreen,
        _chatModel = chatModel,
        _channelName = channelName,
        _interviewModel = interviewModel;

  final double _viewAspectRatio;
  final AgoraUser _user;
  final double? _width;
  final double? _height;
  final void Function()? _onSwitchCamera;
  final Set<AgoraUser> _users;
  final bool _isSmallerScreen;
  final ChatModel _chatModel;
  final String _channelName;
  final InterviewModel _interviewModel;

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      // height: 280,
      // width: 280,
      height: _height,
      width: _width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          width: MediaQuery.of(context).size.width,
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
              // if (_user.isVideoEnabled != true)
              // Center(
              //   child: CircleAvatar(
              //     backgroundColor: Colors.grey.shade800,
              //     maxRadius: 18,
              //     child: Icon(
              //       Icons.person,
              //       color: Colors.grey.shade600,
              //       size: 24.0,
              //     ),
              //   ),
              // ),
              if (_user.isVideoEnabled ?? false)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8 - 2),
                    child: _user.view,
                  ),
                ),
              // Text("userrr ${_user.name} ${_user.uid}"),
              if (_isSmallerScreen && _users.length > 1)
                Positioned(
                  right: 60,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (_onSwitchCamera != null) {
                        _onSwitchCamera!(); //TODO(urgent): revisit
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Image.asset(MyImages.camera, height: 70, width: 70),
                    ),
                  ),
                ),
              if (!_isSmallerScreen && _users.length > 1 && Global.userModel?.type == "user")
                Positioned(
                  left: 40,
                  bottom: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.transparent,
                        color: MyColors.grey.withOpacity(0.2),
                        // color: Colors.black54,  // Semi-transparent background for text
                        alignment: Alignment.center,
                        child: Text(
                          "${_chatModel.selfName}", 
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        // color: Colors.transparent,
                        // color: Colors.black26,  // Semi-transparent background for text
                        color: MyColors.grey.withOpacity(0.2),
                        // alignment: Alignment.centerLeft,
                        child: Text(
                          "${_chatModel.oppTitle}",
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                       Container(
                        // width: 56,
                        height: 32,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                        color: MyColors.grey.withOpacity(0.2),
                        borderRadius:BorderRadius.circular(12),
                        border: Border.all(
                            color: MyColors.transparent, width: 1.2)),
                        alignment: Alignment.center,
                        child: Text(
                          "00:23s",
                          // "1:00:23s",
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (!_isSmallerScreen && _users.length > 1 && Global.userModel?.type != "user")
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 64,
                  child: BlocConsumer<InterviewRecordingCubit, InterviewRecordingState>(
                    listener: (context, state) {
                      if (state is InterviewStartRecordingSuccess) {
                        showToast("Recording started");
                      } else if (state is InterviewStartRecordingErrorState) {
                        showToast("Something went wrong: start recording failed");
                      } else if (state is InterviewStopRecordingSuccess) {
                        showToast("Recording stopped");
                      } else if (state is InterviewStopRecordingErrorState) {
                        showToast("Something went wrong: stop recording failed");
                      }
                    },
                    builder: (context, state) {
                      var text = "Record";
                      var interviewRecordingCubit = context.read<InterviewRecordingCubit>();
                      if (interviewRecordingCubit.recordingStatus == RecordingStatus.notRecording) {
                        text = "Record";
                      } else if (interviewRecordingCubit.recordingStatus == RecordingStatus.recording) {
                        text = "Recording";
                      }
                  
                      return InkWell(
                        onTap: () {
                          // var interviewRecordingCubit = context.read<InterviewRecordingCubit>();
                          // if (interviewRecordingCubit.recordingStatus == RecordingStatus.notRecording) {
                          //    context.read<InterviewRecordingCubit>().startRecording(
                          //     channelName: _channelName,
                          //   );
                  
                          // } else if (interviewRecordingCubit.recordingStatus == RecordingStatus.recording) {
                          //    context.read<InterviewRecordingCubit>().stopRecording(
                          //     channelName: _channelName,
                          //     interviewId: _interviewModel.id,
                          //   );
                          // }
                          var interviewRecordingCubit = context.read<InterviewRecordingCubit>();
                          if (interviewRecordingCubit.recordingStatus == RecordingStatus.notRecording) {                  
                            buildDialog(
                              context,
                              CustomDialog(
                                desc1:
                                    "You can only record once for an interview. If you start now, you can't pause or stop & start to record a new the recording. Are you sure you want to start recording?",
                                descFontColor: MyColors.black,
                                descFontSize: 12,
                                okOnTap: () async {
                                  var interviewRecordingCubit =
                                      context.read<InterviewRecordingCubit>();
                                  if (!interviewRecordingCubit.recordingsDone
                                    .contains(_channelName)) {
                                    context
                                        .read<InterviewRecordingCubit>()
                                        .startRecording(
                                          channelName: _channelName,
                                        );
                                  } else {
                                    showToast(
                                        "Recording already done for this meet.");
                                  }
                                  Navigator.of(context).pop();
                                },
                                cancelOnTap: () {
                                  Navigator.pop(context);
                                },
                                headerImagePath: MyImages.internet,
                            ));
                          } else if (interviewRecordingCubit.recordingStatus == RecordingStatus.recording) {
                             context.read<InterviewRecordingCubit>().stopRecording(
                              channelName: _channelName,
                              interviewId: _interviewModel.id,
                            );
                          }
                          
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: Container(
                                // width: MediaQuery.of(context).size.width * 0.36,
                                // width: 112,
                                width: interviewRecordingCubit.recordingStatus == RecordingStatus.notRecording ? 112 : 132,
                                height: 32,
                                decoration: BoxDecoration(
                                color: MyColors.lightBlack,
                                borderRadius:BorderRadius.circular(24),
                                border: Border.all(
                                    color: MyColors.transparent, width: 1.2)),
                                alignment: Alignment.center,
                                child: Row(children: [
                                  SizedBox(width: 4,),
                                  CircleAvatar(backgroundColor: MyColors.lightBlue,radius: 12),
                                  SizedBox(width: 4,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text(text,style: TextStyle(color: MyColors.white, fontSize: 13),),
                                  ],),
                                  if (state is InterviewRecordingLoading) 
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                ],),
                              ),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.84,
                                height: 56,
                                decoration: BoxDecoration(
                                color: MyColors.lightBlack,
                                borderRadius:BorderRadius.circular(28),
                                border: Border.all(
                                    color: MyColors.transparent, width: 1.2)),
                                alignment: Alignment.center,
                                child: Row(children: [
                                  SizedBox(width: 8,),
                                  CircleAvatar(backgroundColor: Colors.blue,radius: 22),
                                  SizedBox(width: 8,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text("${_chatModel.selfName}",style: TextStyle(color: MyColors.white, fontSize: 16),),
                                    SizedBox(height: 2),
                                    Text("${_chatModel.oppTitle}",style: TextStyle(color: MyColors.greyTxt, fontSize: 14),),
                                  ],),
                                  Spacer(),
                                  Container(
                                    // width: 56,
                                    height: 38,
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                    color: MyColors.greyTxt,
                                    borderRadius:BorderRadius.circular(28),
                                    border: Border.all(
                                        color: MyColors.transparent, width: 1.2)),
                                    alignment: Alignment.center,
                                    child: Text("00:23s"),
                                  ),
                                  SizedBox(width: 8,),
                                ],),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
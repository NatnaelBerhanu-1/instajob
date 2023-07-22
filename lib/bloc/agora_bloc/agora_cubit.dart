import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/agora_bloc/agora_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:permission_handler/permission_handler.dart';

const String appId = '987d58b034624ccfb15d2eaf090659c9';
const String channelId = 'instaJob_channel';
const String token =
    "007eJxTYFDap7josfLXVQuFp7Xaz4wIsX6+esLZr3Emn7eYrXDJnG2kwGBpYZ5iapFkYGxiZmSSnJyWZGiaYpSamGZgaWBmaplsyde0K6UhkJHh5fJuRkYGCATxBRgy84pLEr3yk+KTMxLz8lJzGBgALWolHQ==";

class AgoraBloc extends Cubit<AgoraInitial> {
  AgoraBloc() : super(AgoraInitial());
  RtcEngine? engine;
  int? remoteUid;
  bool localUserJoined = false;
  // CallModel? callModel;

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.camera].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine?.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint(
              "local user ${connection.localUid} joined $localUserJoined");
          localUserJoined = true;
          debugPrint(
              "local user ${connection.localUid} joined $localUserJoined");
          emit(OnJoinChannelSuccess());
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");

          this.remoteUid = remoteUid;
          emit(OnUserJoined());
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");

          remoteUid = remoteUid;
          emit(OnUserOffline());
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onError: (err, msg) {
          print(
              "ERRRRRRRRRRRRRRRRRRRRRRRRRRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
          print(
              "ERRRRRRRRRRRRRRRRRRRRRRRRRRORRRRRRRRR $msg RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
          emit(OnError());
        },
      ),
    );

    await engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine?.enableVideo();
    await engine?.startPreview();

    await engine?.joinChannel(
      token: token,
      channelId: channelId,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Widget remoteVideo() {
    if (remoteUid != null) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              color: MyColors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: engine!,
                canvas: VideoCanvas(uid: remoteUid),
                connection: const RtcConnection(channelId: channelId),
              ),
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Please wait for user to join',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  releaseEngine() {
    engine?.release();
  }
}

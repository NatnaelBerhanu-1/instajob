import 'dart:convert';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/agora_bloc/agora_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:permission_handler/permission_handler.dart';

const String appId = '181c4f5ccf6a49bda4f5bbcf36bc3f92';
const String channelId = 'instaJob_channel';
const String token =
    "007eJxTYGDe3OHjYc1xRHOH+3rmyusufxfGqFiz95TfPu7qGT97R6QCg6WFeYqpRZKBsYmZkUlyclqSoWmKUWpimoGlgZmpZbLlffvtqQ2BjAxydj6MjAwQCOILMGTmFZckeuUnxSdnJOblpeYwMAAAIoAh0A==";

class AgoraBloc extends Cubit<AgoraInitial> {
  AgoraBloc() : super(AgoraInitial());
  RtcEngine? engine;
  int? remoteUid;
  bool localUserJoined = false;

  // CallModel? callModel;

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.camera, Permission.microphone].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine?.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine?.registerEventHandler(
      RtcEngineEventHandler(
        onLocalAudioStats: (RtcConnection connection, LocalAudioStats stats) {},
        // onAudioFrameReceived: (AudioFrame frame) {
        //   // Process the audio frame here
        //   // frame.bytes is the raw audio data
        // },
        onFirstRemoteAudioFrame: (rtc, val, value) {
          log('================== onFirstRemoteAudioFrame =================== ${rtc.toJson()}');
        },

        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("local user ${connection.localUid} joined $localUserJoined");
          localUserJoined = true;
          print("local user ${connection.localUid} joined $localUserJoined");
          // engine?.enableCustomAudioLocalPlayback(trackId: trackId, enabled: enabled);
          engine?.registerAudioEncodedFrameObserver(
              config: const AudioEncodedFrameObserverConfig(
                  encodingType: AudioEncodingType.audioEncodingTypeAac32000High,
                  postionType: AudioEncodedFrameObserverPosition
                      .audioEncodedFrameObserverPositionRecord),
              observer: AudioEncodedFrameObserver(
                onRecordAudioEncodedFrame: (Uint8List frameBuffer, int length,
                    EncodedAudioFrameInfo audioEncodedFrameInfo) {
                  log('================== onRecordAudioEncodedFrame =================== ${audioEncodedFrameInfo.toJson()}  \n$length ${base64Encode(frameBuffer)}');
                },
                onMixedAudioEncodedFrame: (Uint8List frameBuffer, int length,
                    EncodedAudioFrameInfo audioEncodedFrameInfo) {
                  log('================== onMixedAudioEncodedFrame =================== ${audioEncodedFrameInfo.toJson()}  \n$length');
                },
                onPlaybackAudioEncodedFrame: (Uint8List frameBuffer, int length,
                    EncodedAudioFrameInfo audioEncodedFrameInfo) {
                  log('================== onPlaybackAudioEncodedFrame =================== ${audioEncodedFrameInfo.toJson()} s \n$length');
                },
              ));
          engine?.registerAudioSpectrumObserver(AudioSpectrumObserver(
            onLocalAudioSpectrum: (data) {
              log('================== registerAudioSpectrumObserver =================== ${data.toJson()}');
            },
            onRemoteAudioSpectrum:
                (List<UserAudioSpectrumInfo> spectrums, int spectrumNumber) {
              log('================== onRemoteAudioSpectrum =================== ${spectrums.toList()} $spectrumNumber');
            },
          ));

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
          print(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onStreamMessage: (RtcConnection connection, int remoteUid, int streamId,
            Uint8List data, int length, int sentTs) {
          var newData = base64Encode(data);
          log("================= onStreamMessage ===================== $newData");

          log('================== onRemoteAudioSpectrum =================== ${connection.toJson()} $streamId $data');
        },
        onStreamMessageError: (RtcConnection connection, int remoteUid,
            int streamId, ErrorCodeType code, int missed, int cached) {
          print("ERRRRRRRRRRRRR New $code RRRRRRRRRRRRRRRRRRRRRRRRR");
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
    await engine?.enableAudio().then((value) {
      print('++++++++++++++++++++++ AUDIO ENABLE ++++++++++++++++++++++++++');
    });
    engine?.enableLocalAudio(true);
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

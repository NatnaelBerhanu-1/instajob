import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/interview_recording_cubit/interview_recording_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

enum RecordingStatus {
  notRecording,
  recording,
}

class InterviewRecordingCubit extends Cubit<InterviewRecordingState> {
  final JobPositionRepository repo;
  InterviewRecordingCubit(this.repo) : super(InterviewRecordingInitial());

  String? recordingUid = "";
  String? resourceId = "";
  String? sId = "";
  RecordingStatus recordingStatus = RecordingStatus.notRecording;
  
  Future<void> startRecording({required String? channelName}) async {
    emit(InterviewRecordingLoading());
    try {
      // String randomUid = 1000011.toString(); //TODO: REVISIT this static var //note: uid should be int converted to string
      String randomUid = Random().nextInt(1200000).toString(); //TODO: REVISIT this static var //note: uid should be int converted to string
      recordingUid = randomUid;
      ApiResponse response;
      response = await repo.acquireRecordingResource(channelName: channelName, uid: recordingUid);

      if (response.appStatusCode == AppStatusCode.success) {
        var fetchedResourceId = response.response.data['data']['resourceId'];
        resourceId = fetchedResourceId;
        ApiResponse response2 = await repo.startRecordingResource(channelName: channelName, uid: recordingUid, resourceId: resourceId);

        if (response2.appStatusCode == AppStatusCode.success) {
          var fetchedSid = response2.response.data['data']['sid'];
          sId = fetchedSid;
          recordingStatus = RecordingStatus.recording;
          emit(InterviewStartRecordingSuccess());
        } else {
          emit(InterviewStartRecordingErrorState(message: "Data not found"));
        }
      } else {
        emit(InterviewStartRecordingErrorState(message: "Data not found"));
      }
    } on DioException catch (e) {
      emit(InterviewStopRecordingErrorState(message: "Error! Something went wrong"));
    } catch (e) {
      emit(InterviewStartRecordingErrorState(message: "Error! Something went wrong"));
    }
  }

  Future<void> stopRecording({required String? channelName}) async {
    print("LOGG start");
    emit(InterviewRecordingLoading());
    try {
      ApiResponse response;
      response = await repo.stopRecordingResource(
        channelName: channelName,
        uid: recordingUid,
        sid: sId,
        resourceId: resourceId,

      );

      if (response.appStatusCode == AppStatusCode.success) {
          recordingStatus = RecordingStatus.notRecording;
          emit(InterviewStopRecordingSuccess());
      } else {
        emit(InterviewStopRecordingErrorState(message: "Data not found"));
      }
    } on DioException catch (e) {
      emit(InterviewStopRecordingErrorState(message: "Error! Something went wrong"));
    } catch (e) {
      emit(InterviewStopRecordingErrorState(message: "Error! Something went wrong"));
    }
  }

  Future<void> resetState() async {
    //REVISIT all variables being reset
    recordingUid = "";
    resourceId = "";
    sId = "";
    recordingStatus = RecordingStatus.notRecording;
    emit(InterviewRecordingInitial());
  }
}

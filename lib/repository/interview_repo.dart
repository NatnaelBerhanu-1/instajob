import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/payload/end_call_recording_payload.dart';
import 'package:insta_job/payload/end_call_transcription_payload.dart';

import '../network/api_response.dart';
import '../network/end_points.dart';

class InterviewRepo {
  final DioClient dioClient;

  InterviewRepo({required this.dioClient});

  Future<ApiResponse> uploadMp3File({required String file}) async {
    try {
      var map = FormData.fromMap({"file": file});
      var response = await dioClient.post(data: map, uri: EndPoint.uploadMp3File);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getUpcomingInterviews() async {
    //todo: pass stuff (impl)
    try {
      var map = {
        "job_id": "",
        "user_id": "",
      };
      var response = await dioClient.post(data: map, uri: "endpoint");
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getInterviewSchedules(String employeeId) async {
    //both get both upcoming and previous interview schedules
    //todo: pass stuff (impl)
    try {
      debugPrint('EmployeeId: $employeeId');
      var response = await dioClient.post(uri: EndPoint.getInterviews, data: {'employee_id': employeeId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> getInterviewSchedulesAsCandidate(String candidateId) async {
    //similar to getInterviewSchedules
    try {
      debugPrint('CandidateId: $candidateId');
      var response = await dioClient.post(uri: EndPoint.getInterviewsAsCandidate, data: {'candidate_id': candidateId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getPreviousInterviews() { //TODO: revisit (most likely remove this)
    throw Exception();
  }

  Future<ApiResponse> cancelInterviewSchedule({required String callId, required String statusCall}) async {
    try {
      var map = {"call_id": callId, "status_call": statusCall};
      var response = await dioClient.post(uri: EndPoint.cancelInterviewSchedule, data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> endInterviewCallSchedule({required String callId, EndCallRecordingPayload? endCallRecordingPayload, EndCallTranscriptionPayload? endCallTranscriptionPayload}) async {
    try {
      var map = {"call_id": callId, "stop_recording_payload": endCallRecordingPayload?.toMap(), "builder_token": endCallTranscriptionPayload?.toMap()};
      if (endCallRecordingPayload == null) {
        map = {"call_id": callId};
      }
      debugPrint("map payload[end InterviewCallSchedule] $map");
      var response = await dioClient.post(uri: EndPoint.endInterviewCall, data: map);
      debugPrint("map payload[end InterviewCallSchedule] success");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      debugPrint("map payload[end InterviewCallSchedule] error");
      return ApiResponse.withError(e);
    }
  }
  
}

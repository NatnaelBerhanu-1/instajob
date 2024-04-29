import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/network/dio/dio_client.dart';

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

  getPreviousInterviews() {
    throw Exception();
  }
}

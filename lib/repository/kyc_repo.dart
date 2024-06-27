import 'dart:math';

import 'package:dio/dio.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/payload/upload_kyc_candidate_payload.dart';
import 'package:insta_job/payload/upload_kyc_recruiter_payload.dart';

import '../network/api_response.dart';

class KycRepo {
  final DioClient dioClient;

  KycRepo({required this.dioClient});

  Future<ApiResponse> uploadCandidateKyc({required UploadCandidateKycPayload payload, required String userId}) async {
    try {
      var map = {
        // "user_id": Random().nextInt(1000) + 10000,
        "user_id": userId,
        ...payload.toMap(),
      };
      var response = await dioClient.post(data: map, uri: EndPoint.uploadKycCandidate);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

   Future<ApiResponse> uploadRecruiterKyc({required UploadRecruiterKycPayload payload, required String userId}) async {
    try {
      var map = {
        // "user_id": Random().nextInt(1000) + 10000,
        "user_id": userId,
        ...payload.toMap(),
      };
      var response = await dioClient.post(data: map, uri: EndPoint.uploadKycRecruiter);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

}

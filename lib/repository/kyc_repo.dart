import 'package:dio/dio.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/payload/upload_kyc_candidate_payload.dart';
import 'package:insta_job/payload/upload_kyc_recruiter_payload.dart';

import '../network/api_response.dart';

class KycRepo {
  final DioClient dioClient;

  KycRepo({required this.dioClient});

  Future<ApiResponse> uploadCandidateKyc({required UploadCandidateKycPayload payload}) async {
    //todo: pass stuff (impl)
    throw Exception();
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

   Future<ApiResponse> uploadRecruiterKyc({required UploadRecruiterKycPayload payload}) async {
    //todo: pass stuff (impl)
    throw Exception();
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

}

import 'package:dio/dio.dart';
import 'package:insta_job/network/dio/dio_client.dart';

import '../network/api_response.dart';
import '../network/end_points.dart';

class InterviewRepo {
  final DioClient dioClient;

  InterviewRepo({required this.dioClient});

  Future<ApiResponse> uploadMp3File({required String file}) async {
    try {
      var map = FormData.fromMap({"file": file});
      var response =
          await dioClient.post(data: map, uri: EndPoint.uploadMp3File);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:insta_job/network/dio/dio_client.dart';

import '../network/api_response.dart';
import '../network/end_points.dart';

class FeedBackRepository {
  final DioClient dioClient;

  FeedBackRepository({required this.dioClient});

  /// FEEDBACK
  Future<ApiResponse> insertFeedBack({String? feedBack}) async {
    try {
      var map = {"feedback": feedBack};
      var response =
          await dioClient.post(data: map, uri: EndPoint.feedbackInsert);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// AUTOMATE MESSAGE
  Future<ApiResponse> autoMessage({String? feedBack}) async {
    try {
      var map = {"feedback": feedBack};
      var response = await dioClient.post(data: map, uri: EndPoint.autoMsg);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

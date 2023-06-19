import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
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
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// AUTOMATE MESSAGE
  Future<ApiResponse> autoMessage({
    String? applicationReceivedSubject,
    String? applicationReceivedContent,
    String? disqualifiedReviewSubject,
    String? disqualifiedReviewContent,
    String? shortlistedReviewSubject,
    String? shortlistedReviewContent,
    String? autoButton,
    String? empId,
  }) async {
    try {
      var map = {
        "employer_id": Global.userModel?.id.toString(),
        "automate_msg_btn": autoButton,
        "Application_Received_subject": applicationReceivedSubject,
        "Application_Received_content": applicationReceivedContent,
        "Disqualified_review_subject": disqualifiedReviewSubject,
        "Disqualified_review_content": disqualifiedReviewContent,
        "shortlisted_review_subject": shortlistedReviewSubject,
        "shortlisted_review_content": shortlistedReviewContent,
      };
      var response = await dioClient.post(data: map, uri: EndPoint.autoMsg);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

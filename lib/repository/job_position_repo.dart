import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class JobPositionRepository {
  final DioClient dioClient;

  JobPositionRepository({required this.dioClient});

  getJobPositions() async {
    try {
      var map = {"id": Global.userModel?.id};
      var response =
          await dioClient.post(data: map, uri: EndPoint.getJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> addJobPosition({
    String? jobDetails,
    String? requirements,
    String? responsibility,
    String? topSkills,
    String? salaries,
    String? areaDistance,
    String? jobsType,
    String? experienceLevel,
    String? uploadPhoto,
    String? applicationReceivedSubject,
    String? applicationReceivedContent,
    String? disqualifiedReviewSubject,
    String? disqualifiedReviewContent,
    String? shortlistedReviewSubject,
    String? shortlistedReviewContent,
  }) async {
    try {
      Map<String, dynamic> map = {
        "jobdetails": jobDetails,
        "Requirements": requirements,
        "Responsilibites": responsibility,
        "Topskills": topSkills,
        "salaries": salaries,
        "Area_Distance": areaDistance,
        "jobs_Type": jobsType,
        "Experience_level": experienceLevel,
        "upload_photo": uploadPhoto,
        "Application_Received_subject": applicationReceivedSubject,
        "Application_Received_content": applicationReceivedContent,
        "Disqualified_review_subject": disqualifiedReviewSubject,
        "Disqualified_review_content": disqualifiedReviewContent,
        "shortlisted_review_subject": shortlistedReviewSubject,
        "shortlisted_review_content": shortlistedReviewContent,
      };
      Response response =
          await dioClient.post(data: map, uri: EndPoint.addJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

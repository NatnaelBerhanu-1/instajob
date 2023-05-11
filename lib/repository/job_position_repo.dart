import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class JobPositionRepository {
  final DioClient dioClient;

  JobPositionRepository({required this.dioClient});

  getJobPositions({String? id}) async {
    try {
      var map = {"company_id": id ?? ""};
      var response =
          await dioClient.post(data: map, uri: EndPoint.getJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> saveJob({String? jobId}) async {
    try {
      Response response = await dioClient.post(
          data: {"job_id": jobId, "user_id": Global.userModel?.id.toString()},
          uri: EndPoint.insertSaveJob);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getSavedJob() async {
    try {
      Response response = await dioClient
          .post(data: {"user_id": Global.userModel?.id}, uri: EndPoint.saveJob);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> applyForJob({String? jobId, String? resume}) async {
    var map = {
      "user_id": Global.userModel?.id,
      "job_id": "2",
      "upload_resume": resume
    };
    try {
      Response response =
          await dioClient.post(data: map, uri: EndPoint.applyForJob);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> deleteJobPosition({String? jobId}) async {
    try {
      Response response = await dioClient
          .post(data: {"id": jobId}, uri: EndPoint.deleteJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> addJobPosition({
    String? companyId,
    String? designation,
    String? jobDetails,
    String? requirements,
    String? responsibility,
    List? topSkills,
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
        "company_id": companyId,
        "designation": designation,
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

  Future<ApiResponse> updateJobPosition({
    String? jobDetails,
    String? designation,
    String? id,
    bool? isUpdate,
    String? requirements,
    String? responsibility,
    List? topSkills,
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
        "id": id,
        "designation": designation,
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
          await dioClient.post(data: map, uri: EndPoint.editJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/resume_detail_model.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class ResumeRepository {
  final DioClient dioClient;

  ResumeRepository({required this.dioClient});

  Future<ApiResponse> addResume({
    String? name,
    String? phoneNumber,
    String? skills,
    String? pWork,
    String? passion,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "your_name": name,
      "phone_number": phoneNumber,
      "your_top_5_skills": skills,
      "previous_work": pWork,
      "your_passion": passion,
      "upload_resume": "test"
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.addResume);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  getResume({String? id}) async {
    try {
      var map = {"id": id};
      var response = await dioClient.post(data: map, uri: EndPoint.getResume);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// Edit Resume Api's

  Future<ApiResponse> addTellAbtSelf({
    String? tellUs,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "tell_us": tellUs ?? "",
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.tellUs);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> addEducation({
    required Educations education,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "institution_name": education.institutionName ?? "",
      "field_of_study": education.fieldOfStudy ?? "",
      "state": education.educationState ?? "",
      "city": education.educationCity ?? "",
      "school_history": education.schoolHistory ?? "",
      "start_month": education.educationStartMonth ?? "",
      "end_month": education.educationEndMonth ?? "",
      "start_year": education.educationStartYear ?? "",
      "end_year": education.educationEndYear ?? "",
      "education_custom_message": education.educationCustomMessage ?? "",
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.addEducation);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> addWorkExperience({
    required WorkExperiences workExpModel,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "job_title": workExpModel.jobTitle ?? "",
      "employer": workExpModel.employer ?? "",
      "state": workExpModel.workState ?? "",
      "city": workExpModel.workCity ?? "",
      "work_history": workExpModel.workHistory ?? "",
      "start_month": workExpModel.workStartMonth ?? "",
      "end_month": workExpModel.workEndMonth ?? "",
      "start_year": workExpModel.workStartYear ?? "",
      "end_year": workExpModel.workEndYear ?? "",
      "work_custom_message": workExpModel.workCustomMessage ?? "",
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.addWorkExperience);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> addSkills({
    List<String>? skills,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "add_skill": skills ?? [],
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.addSkills);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> addAchievement({
    List<String>? ach,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "achivments_skill": ach ?? [],
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.addAchievement);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> showCreatedResumes({String? userId}) async {
    var data = {
      "user_id":
          Global.userModel?.type == "user" ? Global.userModel?.id : userId,
    };
    try {
      Response response =
          await dioClient.post(data: data, uri: EndPoint.showCreatedResumes);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  deleteWorkExp({String? id}) async {
    try {
      var map = {"id": id};
      var response =
          await dioClient.post(data: map, uri: EndPoint.deleteWorkingExp);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  deleteEducation({String? id}) async {
    try {
      var map = {"id": id};
      var response =
          await dioClient.post(data: map, uri: EndPoint.deleteEducation);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  getParsedResumeDetails({required String? resumeUrl}) async {
    try {
      if (resumeUrl == null) {
        return ApiResponse.withError("No resume given");
      }
      var fullResumeUrl = "${EndPoint.imageBaseUrl}$resumeUrl";
      var queryParams = {"url": fullResumeUrl};
      var fullEndpointUrlPath = "https://api.apilayer.com/resume_parser/url";
      var response = await Dio().get(
        fullEndpointUrlPath,
        data: {},
        options: Options(
          headers: {
            // "Content-Type": "application/json",
            "apikey": "qBCCB5UVnBS3JDSSfxTeXAb27bg8o9Ce"
          },
        ),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        ResumeDetailModel resumeDetails =
            ResumeDetailModel.fromJson(response.data);
        return ApiResponse.withSuccess(resumeDetails);
      }
      return ApiResponse.withError("Something happened when parsing resume");
    } on DioException catch (e, s) {
      return ApiResponse.withError(e.response);
    }
  }
}

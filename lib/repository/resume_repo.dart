import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
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
    required ResumeModel resumeModel,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "institution_name": resumeModel.institutionName ?? "",
      "field_of_study": resumeModel.fieldOfStudy ?? "",
      "state": resumeModel.state ?? "",
      "city": resumeModel.city ?? "",
      "school_history": resumeModel.schoolHistory ?? "",
      "start_month": resumeModel.startMonth ?? "",
      "end_month": resumeModel.endMonth ?? "",
      "start_year": resumeModel.startYear ?? "",
      "end_year": resumeModel.endYear ?? "",
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
    required ResumeModel resumeModel,
  }) async {
    var data = {
      "user_id": Global.userModel?.id,
      "job_title": resumeModel.jobTitle ?? "",
      "employer": resumeModel.employer ?? "",
      "state": resumeModel.state ?? "",
      "city": resumeModel.city ?? "",
      "work_history": resumeModel.workHistory ?? "",
      "start_month": resumeModel.startMonth ?? "",
      "end_month": resumeModel.endMonth ?? "",
      "start_year": resumeModel.startYear ?? "",
      "end_year": resumeModel.endYear ?? "",
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
}

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/filter_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:path_provider/path_provider.dart';

class JobPositionRepository {
  final DioClient dioClient;

  JobPositionRepository({required this.dioClient});

  getJobPositions({String? id}) async {
    try {
      var map = {"company_id": id ?? "", "user_id": Global.userModel?.id};
      var response = await dioClient.post(data: map, uri: EndPoint.getJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> saveJob({String? jobId, String? jobStatus}) async {
    try {
      Response response = await dioClient.post(
          data: {"job_id": jobId, "user_id": Global.userModel?.id.toString(), "job_status": jobStatus},
          uri: EndPoint.insertSaveJob);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getSavedJob() async {
    try {
      debugPrint('UserId: ${Global.userModel?.id}');
      Response response = await dioClient.post(data: {"user_id": Global.userModel?.id}, uri: EndPoint.showSaveJob);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> applyForJob({String? jobId, String? resume}) async {
    var map = {"user_id": Global.userModel?.id, "job_id": jobId, "upload_resume": resume};
    try {
      Response response = await dioClient.post(data: map, uri: EndPoint.applyForJob);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getAppliedJob({String? jobId, String? status}) async {
    var map = {
      "user_id": Global.userModel?.type == "user" ? Global.userModel?.id : "",
      "job_id": jobId ?? "",
      "status": status ?? ""
    };
    // if (jobId == null) {
    //   map = {
    //     // "user_id": Global.userModel?.type == "user" ? Global.userModel?.id : "",
    //     "job_id": jobId ?? "",
    //     "status": status ?? ""
    //   };
    // }
    // // if (status != null) {
    // //   map["status"] = status;
    // // }

    try {
      Response response = await dioClient.post(
          data: map, uri: EndPoint.getAppliedJob); //this endpoint is for all (applied, shortlisted, declined)
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  // new -> separated denied candidates request
  Future<ApiResponse> getDeniedCandidates({String? jobId, String? status}) async {
    var map = {"job_id": jobId ?? "", "status": status ?? ""};
    print("LOGG ${map}");
    try {
      Response response = await dioClient.post(
          data: map, uri: EndPoint.getAppliedJob); //note: this endpoint is for all (applied, shortlisted, declined)
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> shortlistOrDenied({required String appliedListId, String? status}) async {
    var map = {"id": appliedListId, "status": status ?? "applied"};
    debugPrint("LOGG shortlist or denied map $map");
    try {
      Response response = await dioClient.post(data: map, uri: EndPoint.shortlistOrDenied);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> hireCandidate({required String appliedListId}) async {
    var map = {"id": appliedListId, "status": "hired"};
    debugPrint("LOGG hire map $map");
    try {
      Response response = await dioClient.post(data: map, uri: EndPoint.shortlistOrDenied);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    } catch(e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> deleteJobPosition({String? jobId}) async {
    try {
      Response response = await dioClient.post(data: {"id": jobId}, uri: EndPoint.deleteJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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
      Response response = await dioClient.post(data: map, uri: EndPoint.addJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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
      Response response = await dioClient.post(data: map, uri: EndPoint.editJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  searchJobs(FilterModel filterModel) async {
    try {
      var map = {
        "search_jobs": filterModel.searchJobs ?? "",
        "start_salary": filterModel.startSalary ?? "",
        "end_salary": filterModel.endSalary ?? "",
        "area_distance": filterModel.areaDistance ?? "",
        "jobs_Type": filterModel.jobsType ?? "",
        "jobs_Source": filterModel.jobsSource ?? "",
        "Experience_level": filterModel.experienceLevel ?? "",
        "last_24": filterModel.last24 ?? "",
        "last_3": filterModel.last3 ?? "",
        "last_7": filterModel.last7 ?? "",
        "last_14": filterModel.last14 ?? "",
        "sortbydate": filterModel.sortbydate ?? "",
      };
      var response = await dioClient.post(data: map, uri: EndPoint.searchJob);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  jobDistanceLocator({String? designation, String? miles, double? lat, double? long}) async {
    try {
      var map = {"designation": designation, "Area_Distance": miles, "lat": lat, "long": long};
      var response = await dioClient.post(data: map, uri: EndPoint.getJobPosition);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  setInterview({
    String? companyId,
    String? employeeId,
    String? jobId,
    String? userId,
    String? time,
    String? timeType, 
    String? channelName,
  }) async {
    try {
      var map = {
        "company_id": companyId,
        "employee_id": employeeId,
        "job_id": jobId,
        "user_id": userId,
        "time": time,
        "time_type": timeType,
        "channel_name": channelName,
      };
      var response = await dioClient.post(data: map, uri: EndPoint.createVideoCall);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  acquireRecordingResource({
    String? channelName,
    String? uid,
  }) async {
    try {
      var map = {
        "channel_name": channelName,
        "uid": uid,
      };
      var urlPath = "${EndPoint.recordingBaseUrl}${EndPoint.acquireRecording}";
      var response = await Dio().post(urlPath, data: map);
      return ApiResponse.withSuccess(response);
    // } on DioException catch (e) {
    } catch (e) {
      return ApiResponse.withError("e.response");
    }
  }

  
  startRecordingResource({
    String? channelName,
    String? uid,
    String? resourceId,
  }) async {
    try {
      var map = {
        "channel": channelName,
        "uid": uid,
        "resource": resourceId,
      };
      var urlPath = "${EndPoint.recordingBaseUrl}${EndPoint.startRecording}";
      var response = await Dio().post(urlPath, data: map);
      // var response = await dioClient.post(data: map, uri: EndPoint.startRecording);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    } catch (e) {
      return ApiResponse.withError("e.response");
    }
  }

    
  startTranscription({
    String? channelName,
  }) async {
    try {
      var map = {
        "channel_name": channelName,
      };
      var urlPath = "${EndPoint.recordingBaseUrl}${EndPoint.startTranscription}";
      var response = await Dio().post(urlPath, data: map);
      // var response = await dioClient.post(data: map, uri: EndPoint.startRecording);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    } catch (e) {
      return ApiResponse.withError("e.response");
    }
  }

    
  stopRecordingResource({
    String? channelName,
    String? sid,
    String? resourceId,
    String? uid, 
    int? interviewId,
  }) async {
    try {
      var map = {
        "resource": resourceId,
        "sid": sid,
        "channel": channelName,
        "uid": uid,
        "interview_id": interviewId.toString(), //revisit
      };
      debugPrint("stop recording payload map ${map}");
      var urlPath = "${EndPoint.recordingBaseUrl}${EndPoint.stopRecording}";
      var response = await Dio().post(urlPath, data: map);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  String kGoogleApiKey = "AIzaSyAwEmv3whQry4abe7SnIuPS4ttniNdkLuI";

  Future<ApiResponse> getPlaceById(String placeId) async {
    try {
      final response = await dioClient.get(
          data: {},
          uri: "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$kGoogleApiKey");
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getLocation(String input) async {
    try {
      final response = await dioClient.get(
          data: {},
          uri:
              "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyAwEmv3whQry4abe7SnIuPS4ttniNdkLuI&type=address");
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<int> getJobMatchScore(int userId, String jobDetails, String resumeUrl) async {
    try {
      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();
      // Define the path for the temporary file
      final tempFilePath = '${tempDir.path}/temp_resume${Random().nextInt(10000) + 1}.pdf';

      var response = await dioClient.dio?.downloadUri(Uri.parse(resumeUrl), tempFilePath);
      if (response?.statusCode == 200) {
        FormData formData = FormData.fromMap({
          'resume': await MultipartFile.fromFile(tempFilePath),
          'api_key': "86wbdiu23hu134jsdf", // TODO: move to ENV later
          'job_description': jobDetails
        });

        var response = await dioClient.dio?.post(EndPoint.resumeMatcherNewFull, data: formData);
        debugPrint("StatusCode: ${response?.statusCode.toString()}");
        debugPrint("Response: ${response?.data}");
        if (response?.statusCode == 200) {
          var data = response?.data as Map<String, dynamic>;
          if (data.containsKey('score')) {
            return (data['score'] as double).toInt();
          } else {
            throw Exception('Score not found');
          }
        } else {
          throw Exception('Something went wrong');
        }
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e, stk) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: stk);
      return 0;
    }
  }

  Future<ApiResponse> getHiredCandidates({String? jobId}) async {
    String emp_id = Global.userModel?.id.toString() ?? "";
    var map = {"employee_id": emp_id};
    print("LOGG get hired list map ${map}");
    try {
      Response response = await dioClient.post(
          data: map, uri: EndPoint.getHiredCandidates); //note: this endpoint is for all (applied, shortlisted, declined), AND hired(newly added status)
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getPaymentLink(String user_id, String recruiter_id, double amount) async {
    // final dio = Dio(
    //   BaseOptions(
    //     baseUrl: 'https://finix.sandbox-payments-api.com/',
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Finix-Version': '2022-02-01',
    //       'Authorization': 'Basic ' + base64Encode(utf8.encode('USksBJMwkNUz5GyxPevL2yFY:71b641c1-861d-435b-9a9c-532760731c5e')),
    //     },
    //   ),
    // );
    // final data = {
    //   "merchant_id": 'merchantId',// change merchant id
    //   "payment_frequency": "ONE_TIME",
    //   "allowed_payment_methods": [
    //     "PAYMENT_CARD",
    //     "BANK_ACCOUNT"
    //   ],
    //   "nickname": 'nickname', //
    //   "amount_details": {
    //     "amount_type": "FIXED",
    //     "total_amount": amount,
    //     "currency": "USD"
    //   },
    //   "items": [
    //     {
    //       "name": name,
    //       "quantity": "1",
    //       "image_details": {
           
    //       },
    //       "price_details": {
    //         "sale_amount": amount,
    //         "currency": "USD"
    //       }
    //     }
    //   ]
    // };
    try {
      Response response = await dioClient.post(
          data: {'user_id':user_id,
            'recruiter_id':recruiter_id,
            'amount':amount,}, uri: EndPoint.paymentLink);
      if(response.statusCode == 200) {
      return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(response);
      }
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

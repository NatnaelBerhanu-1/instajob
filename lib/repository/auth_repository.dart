import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository({required this.dioClient});

  /// EMPLOYEE REGISTRATION
  Future<ApiResponse> empRegister({
    String? name,
    String? email,
    String? password,
    String? date,
    String? profilePic,
    String? phoneNumber,
    String? cv,
    String? companyName,
    String? websiteLink,
    bool isUser = false,
  }) async {
    try {
      var map = isUser
          ? {
              "name": name,
              "email": email,
              "password": password,
              "date": date,
              "cv": cv,
              "phone_number": phoneNumber,
              "upload_photo": profilePic,
              "type": userType == "user" ? "user" : "recruiters",
              "fcm_token": "1234",
              "firebase_id": FirebaseAuth.instance.currentUser?.uid,
            }
          : {
              "name": name,
              "email": email,
              "password": password,
              "phone_number": phoneNumber,
              "upload_photo": profilePic,
              "company_name": companyName,
              "website_link": websiteLink,
              "type": userType == "user" ? "user" : "recruiters",
              "fcm_token": "1234",
              "firebase_id": FirebaseAuth.instance.currentUser?.uid,
            };
      Response response = await dioClient.post(
          data: map,
          uri: isUser ? EndPoint.registerUser : EndPoint.registerEmp);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// EMPLOYEE LOGIN
  Future<ApiResponse> empLogin({
    String? email,
    String? password,
    bool isUser = false,
  }) async {
    try {
      var map = {
        "email": email,
        "password": password,
      };
      Response response = await dioClient.post(
          data: map, uri: isUser ? EndPoint.loginUser : EndPoint.loginEmp);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      print(" RESPONCE 99999999999999999990 ${e.response}");
      return ApiResponse.withError(e.response);
    }
  }

  /// CHECK USER
  Future<ApiResponse> checkUser(String email) async {
    try {
      var map = {
        "email": email,
      };
      print('TYPE **********************            $userType');
      Response response =
          await dioClient.post(data: map, uri: EndPoint.checkUser);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// UPDATE USER
  Future<ApiResponse> updateUser({
    String? name,
    String? phoneNumber,
    String? profilePhoto,
    String? dOB,
  }) async {
    try {
      var map = {
        "id": Global.userModel?.id,
        "name": name,
        "email": Global.userModel?.email,
        "date": dOB,
        "phone_number": phoneNumber,
        "password": "123456",
        "upload_photo": profilePhoto
      };
      Response response =
          await dioClient.post(data: map, uri: EndPoint.updateUser);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// UPDATE EMPLOYEE
  Future<ApiResponse> updateEmp({
    String? companyName,
    String? phoneNumber,
    String? profilePhoto,
  }) async {
    try {
      var map = {
        "id": Global.userModel?.id,
        "companyname": companyName,
        "phone_number": Global.userModel?.phoneNumber,
        "email": "${Global.userModel?.email}",
        "upload_photo": profilePhoto
      };
      Response response =
          await dioClient.post(data: map, uri: EndPoint.employeeUpdate);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  /// LOGOUT
  Future<ApiResponse> logOutUser() async {
    try {
      var map = {"id": Global.userModel?.id};
      Response response = await dioClient.post(data: map, uri: EndPoint.logout);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

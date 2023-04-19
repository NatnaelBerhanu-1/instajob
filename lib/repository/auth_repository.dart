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
    bool isUser = false,
  }) async {
    try {
      var map = {
        "name": name,
        "email": email,
        "password": password,
        "type": userType == "user" ? "user" : "jobsearch",
        "fcm_token": "1234",
        "firebase_id": FirebaseAuth.instance.currentUser?.uid,
      };
      Response response = await dioClient.post(
          data: map,
          uri: isUser ? EndPoint.registerUser : EndPoint.registerEmp);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e);
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
      return ApiResponse.withError(e);
    }
  }

  /// CHECK USER
  Future<ApiResponse> checkUser(String email) async {
    try {
      var map = {"email": email};
      Response response =
          await dioClient.post(data: map, uri: EndPoint.checkUser);
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

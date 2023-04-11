import 'package:dio/dio.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository({required this.dioClient});

  Future<ApiResponse> registerEmp({
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      var map = {
        "name": name,
        "email": email,
        "password": password,
        "type": "jobsearch",
        "fcm_token": "1234",
        "firebase_id": "1234"
      };
      Response response =
          await dioClient.post(data: map, uri: EndPoint.registerEmp);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> loginEmp({
    String? email,
    String? password,
  }) async {
    try {
      var map = {
        "email": email,
        "password": password,
      };
      Response response =
          await dioClient.post(data: map, uri: EndPoint.loginEmp);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e);
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final SharedPreferences? sharedPreferences;
  final String? baseUrl;

  Dio? dio;

  DioClient({this.sharedPreferences, this.baseUrl, required Dio dioC}) {
    dio = dioC;
    dio!
      ..options.baseUrl = EndPoint.baseUrl
      ..options.headers = {
        "content-type": "application/json",
      };
    dio?.interceptors.add(PrettyDioLogger());
  }
  Future<Response> post({dynamic data, required String uri}) async {
    print("ENCODE DATA --->  ${jsonEncode(data)}");
    print("URL --->  $uri");
    try {
      Response response = await dio!.post(
        uri,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(
      {required Map<String, dynamic> data,
      required String uri,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio!.get(uri,
          options: Options(
            headers: header,
          ),
          queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      showToast(e.message);
      throw const FormatException("Unable to load");
    } catch (e) {
      rethrow;
    }
  }
}

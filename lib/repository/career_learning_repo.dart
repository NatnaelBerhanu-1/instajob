import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class CareerLearningRepo {
  final DioClient dioClient;

  CareerLearningRepo(this.dioClient);

  getCareerClusterList({String? code, bool isDetail = false}) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('instajob_online:6322ugb'))}';
    print("BASIC AUTH ========== $basicAuth");
    try {
      var response = await dioClient.get(
        uri: isDetail
            ? "${EndPoint.getCareerCluster}${code ?? "1.0000"}"
            : EndPoint.getCareerCluster,
        data: {},
        header: {
          "Accept": "application/json",
          "Authorization": basicAuth,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  getClusterDetailList(String url) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('instajob_online:6322ugb'))}';
    print("BASIC AUTH ========== $basicAuth");
    try {
      var response = await dioClient.get(
        uri: url,
        data: {},
        header: {
          "Accept": "application/json",
          "Authorization": basicAuth,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  taskDetailList(String code, String name) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('instajob_online:6322ugb'))}';
    print("BASIC AUTH ========== $basicAuth");
    try {
      var response = await dioClient.get(
        uri:
            "https://services.onetcenter.org/ws/online/occupations/$code/summary/$name",
        data: {},
        header: {
          "Accept": "application/json",
          "Authorization": basicAuth,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

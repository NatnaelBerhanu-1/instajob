import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class AiQuestionsRepository {
  final DioClient dioClient;

  AiQuestionsRepository({required this.dioClient});

  Future<ApiResponse> getInitialQuestions(
      {String? cvUrl, String? jobDescription}) async {
    try {
      var urlPath =
          "${EndPoint.questionGeneratorBaseUrl}${EndPoint.generateInitialQuestions}";
      var data = {
        "cv_url": cvUrl,
        'job_description': jobDescription,
      };

      Response response = await Dio().post(
        urlPath,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e, stk) {
      debugPrint('$e');
      debugPrintStack(stackTrace: stk);
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getSummarizedQuestions(
      {String? conversationContent}) async {
    //not tested
    try {
      var urlPath =
          "${EndPoint.questionGeneratorBaseUrl}${EndPoint.summarizeInterview}";
      var map = {
        {
          "conv_lst": [
            {"type": "string", "content": "$conversationContent"}
          ]
        }
      };
      var response = await Dio().post(
        urlPath,
        data: map,
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

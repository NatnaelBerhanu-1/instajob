import 'package:dio/dio.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class AiQuestionsRepository {
  final DioClient dioClient;

  AiQuestionsRepository({required this.dioClient});

  Future<ApiResponse> getInitialQuestions(
      {String? cvUrl, String? jobDescription}) async {
    try {
      //     data: map, uri: EndPoint.getHiredCandidates); //note: this endpoint is for all (applied, shortlisted, declined), AND hired(newly added status)
      var urlPath =
          "${EndPoint.questionGeneratorBaseUrl}${EndPoint.generateInitialQuestions}";
      var queryParams = {
        // 'cv_url': cvUrl,
        "cv_url":
            "https://shaybani-web-crimson-water-6355.fly.dev//storage/files/663345b510d7a.pdf",
        'job_description': jobDescription,
      };

      // FormData formData = FormData.fromMap(
      //     {'cv_url': cvUrl, 'job_description': jobDescription});

      // final response = await Dio().post(urlPath, data: formData);
      Response response = await Dio().post(
        urlPath,
        data: queryParams,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  Future<ApiResponse> getSummarizedQuestions(
      {String? conversationContent}) async {
    try {
      //     data: map, uri: EndPoint.getHiredCandidates); //note: this endpoint is for all (applied, shortlisted, declined), AND hired(newly added status)
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

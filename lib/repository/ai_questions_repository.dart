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
      // Response response = await dioClient.post(
      //     data: map, uri: EndPoint.getHiredCandidates); //note: this endpoint is for all (applied, shortlisted, declined), AND hired(newly added status)
      var urlPath =
          "${EndPoint.questionGeneratorBaseUrl}${EndPoint.generateInitialQuestions}";
      // Create the request body
      // FormData formData = FormData.fromMap({
      //   'cv_url': cvUrl,
      //   'job_description': jobDescription,
      // });
      var map = {
        'cv_url': cvUrl,
        'job_description': jobDescription,
      };
      Response response = await Dio().post(
        urlPath,
        data: map,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

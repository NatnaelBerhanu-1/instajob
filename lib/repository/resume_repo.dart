import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
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
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  getResume({String? id}) async {
    try {
      var map = {"id": id};
      var response = await dioClient.post(data: map, uri: EndPoint.getResume);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';

class CompanyRepository {
  final DioClient dioClient;

  CompanyRepository({required this.dioClient});

  getCompanies() async {
    try {
      var map = {"employe_id": Global.userModel?.id.toString()};
      var response =
          await dioClient.post(data: map, uri: EndPoint.getCompanies);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  addCompany({required String name, required String photo}) async {
    try {
      var map = {
        "employe_id": Global.userModel?.id.toString(),
        "companyname": name,
        "upload_photo": photo
      };
      var response = await dioClient.post(data: map, uri: EndPoint.addCompany);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  searchCompany({String? search}) async {
    try {
      var map = {
        "search": search,
        "type": "type",
        "employe_id": "empId",
      };
      var response =
          await dioClient.post(data: map, uri: EndPoint.searchCompany);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  base64ImgApi(value) async {
    try {
      var map = {"file": value};
      var response = await dioClient.post(data: map, uri: EndPoint.base64);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

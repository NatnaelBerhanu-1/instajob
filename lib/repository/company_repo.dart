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
      var map = {
        "employe_id":
            Global.userModel?.type == "user" ? "" : Global.userModel?.id
      };
      print("TYPE *********** !!!!!!!!!!!!  ${Global.userModel?.type}");
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
        "employe_id":
            Global.userModel?.type == "user" ? "" : Global.userModel?.id,
      };
      var response =
          await dioClient.post(data: map, uri: EndPoint.searchCompany);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  searchJobs({String? search}) async {
    try {
      var map = {
        "search_jobs": search ?? "",
      };
      var response = await dioClient.post(data: map, uri: EndPoint.searchJob);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }

  base64ImgApi(value, extension) async {
    try {
      var map = {"file": value, "extension": extension};
      var response = await dioClient.post(data: map, uri: EndPoint.base64);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

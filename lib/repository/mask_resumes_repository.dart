import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';

class MaskResumesRepository {
  final DioClient dioClient;

  MaskResumesRepository({required this.dioClient});

  downloadMultiplePdfs({
    required BuildContext context,
    required List<String> resumesPaths,
  }) async {
    try {
      List<String>? downloadedFilesUrl =
          await Global().downloadMultiplePdfsNew(resumesPaths);
      if (downloadedFilesUrl != null) {
        return ApiResponse.withSuccess(
          downloadedFilesUrl,
          AppStatusCode.success,
        );
      }
      return ApiResponse.withError("Something happened");
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

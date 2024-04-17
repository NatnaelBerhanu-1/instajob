import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';

class AttachmentDownloadRepository {
  final DioClient dioClient;

  AttachmentDownloadRepository({required this.dioClient});

  downloadMultiplePdfs({
    required BuildContext context,
    required List<String> resumesPaths,
  }) async {
    try {
      List<String>? downloadedFilesUrl =
          await Global().downloadMultiplePdfsNew(context, resumesPaths);
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

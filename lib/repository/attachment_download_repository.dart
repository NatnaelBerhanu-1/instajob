import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';

class AttachmentDownloadRepository {
  final DioClient dioClient;

  AttachmentDownloadRepository({required this.dioClient});

  downloadMultiplePdfs({
    required List<String> resumesPaths,
    required bool maskTheResumes,
  }) async {
    try {
      List<String>? downloadedFilesUrl =
          await Global().downloadMultiplePdfsNew(resumesPaths);
      List<String>? maskedDownloadedFilesUrl = [];
      if (downloadedFilesUrl != null) {
        if (maskTheResumes == false) {
          return ApiResponse.withSuccess(
            downloadedFilesUrl,
            AppStatusCode.success,
          );
        }
        maskedDownloadedFilesUrl = await Global()
            .maskMultipleResumesAndDownloadthem(downloadedFilesUrl);
        if (maskedDownloadedFilesUrl != null) {
          return ApiResponse.withSuccess(
            maskedDownloadedFilesUrl,
            AppStatusCode.success,
          );
        }
      }
      return ApiResponse.withError("Something happened");
    } on DioException catch (e) {
      return ApiResponse.withError(e.response);
    }
  }
}

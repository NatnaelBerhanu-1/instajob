import 'package:dio/dio.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/dio/dio_client.dart';

class ResumeMatcherRepository {
  final DioClient dioClient;

  ResumeMatcherRepository({required this.dioClient});

  downloadMultiplePdfsForResumeMatching({
    required List<String> resumesPaths,
  }) async {
    // unimplemented //TODO:(URGENT)
    try {
      List<String>? downloadedFilesUrl =
          await Global().downloadMultiplePdfsNew(resumesPaths);
      // List<String>? resumeMatchedDownloadedFilesUrl = []; //revisit justincase
      if (downloadedFilesUrl != null) {
        List<int>? scoresList =
            await Global().getResumesMatchingScore(downloadedFilesUrl);
        if (scoresList != null) {
          return ApiResponse.withSuccess(
            scoresList,
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

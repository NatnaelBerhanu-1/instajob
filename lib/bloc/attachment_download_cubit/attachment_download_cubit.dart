import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/attachment_download_cubit/attachment_download_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/attachment_download_repository.dart';

class AttachmentDownloadCubit extends Cubit<AttachmentDownloadState> {
  final AttachmentDownloadRepository repo;
  AttachmentDownloadCubit(this.repo) : super(AttachmentDownloadInitial());

  Future<void> execute({
    required BuildContext context,
    required List<String> resumesPaths,
    required bool maskTheResumes,
  }) async {
    emit(AttachmentDownloadLoading());
    ApiResponse response = await repo.downloadMultiplePdfs(
      resumesPaths: resumesPaths,
      maskTheResumes: maskTheResumes,
    );

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(AttachmentDownloadErrorState(
          message: "Server error. Something went wrong. Please try again."));
    }
    if (response.appStatusCode == AppStatusCode.success) {
      List<String>? downloadedFilesUrlPaths =
          response.response as List<String>?;
      emit(AttachmentDownloadSuccess(
          downloadedFilesUrlPaths: downloadedFilesUrlPaths));
    } else {
      emit(AttachmentDownloadErrorState(message: "Data not found"));
    }
  }
}

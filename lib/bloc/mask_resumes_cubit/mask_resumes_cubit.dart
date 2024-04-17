import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/mask_resumes_cubit/mask_resumes_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/mask_resumes_repository.dart';

class MaskResumesCubit extends Cubit<MaskResumesState> {
  final MaskResumesRepository repo;
  MaskResumesCubit(this.repo) : super(MaskResumesInitial());

  Future<void> execute({
    required BuildContext context,
    required List<String> resumesPaths,
  }) async {
    emit(MaskResumesLoading());
    ApiResponse response = await repo.downloadMultiplePdfs(
      context: context,
      resumesPaths: resumesPaths,
    );

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(MaskResumesErrorState(
          message: "Server error. Something went wrong. Please try again."));
    }
    if (response.appStatusCode == AppStatusCode.success) {
      List<String>? downloadedMaskedFilesUrlPaths =
          response.response as List<String>?;
      emit(MaskResumesSuccess(
        resumesAreMasked: false,
        downloadedMaskedFilesUrlPaths: downloadedMaskedFilesUrlPaths,
      ));
    } else {
      emit(MaskResumesErrorState(message: "Data not found"));
    }
  }
}

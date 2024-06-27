import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/upload_kyc_bloc/upload_kyc_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/payload/upload_kyc_candidate_payload.dart';
import 'package:insta_job/payload/upload_kyc_payload.dart';
import 'package:insta_job/payload/upload_kyc_recruiter_payload.dart';
import 'package:insta_job/repository/kyc_repo.dart';

class UploadKycCubit extends Cubit<UploadKycState> {
  final KycRepo repo;
  UploadKycCubit(this.repo) : super(UploadKycInitial());

  Future<void> uploadKyc({required UploadKycPayload uploadKycPayload}) async {
    emit(UploadKycLoading());
    try {
      await Future.delayed(const Duration(seconds: 10));
      ApiResponse response;
      int? userIdInt = Global.userModel?.id;
      String userId = userIdInt != null ? userIdInt.toString() : "";
      
      if (uploadKycPayload is UploadCandidateKycPayload) {
        response = await repo.uploadCandidateKyc(payload: uploadKycPayload, userId: userId);
      } else if (uploadKycPayload is UploadRecruiterKycPayload) {
        response = await repo.uploadRecruiterKyc(payload: uploadKycPayload, userId: userId);
      } else {
        throw Exception();
      }
      if (response.appStatusCode == AppStatusCode.serverError) {
        emit(UploadKycErrorState(message: "Server error. Something went wrong. Please try again."));
      } else if (response.appStatusCode == AppStatusCode.success) {
        emit(UploadKycSuccess());
      } else {
        emit(UploadKycErrorState(message: "Something went wrong: Upload KYC failed. Make sure you fill every field."));
      }
    } catch(e) {
      emit(UploadKycErrorState(message: "Something went wrong: Upload KYC failed. Make sure you fill every field."));
    }
  }
}

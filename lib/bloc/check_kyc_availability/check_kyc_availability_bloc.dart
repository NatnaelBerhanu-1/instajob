import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_state.dart';
import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_candidate_data.dart';
import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_data.dart';
import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_recruiter_data.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/kyc_repo.dart';

class CheckKycAvailabilityCubit extends Cubit<CheckKycAvailabilityState> {
  final KycRepo kycRepo;
  CheckKycAvailabilityCubit(this.kycRepo)
      : super(CheckKycAvailabilityInitialState());

  Future<void> execute({required String userId}) async {
    emit(const CheckKycAvailabilityLoading());
    try {
      ApiResponse response;
      if (userIsCandidate() == true) {
        response = await kycRepo.checkKycCandidateAvailability(userId: userId);
      } else {
        response = await kycRepo.checkKycRecruiterAvailability(userId: userId);
      }
      if (response.response.statusCode == 500) {
        emit(const CheckKycAvailabilityErrorState(
            message: 'Something went wrong'));
      }
      if (response.response.statusCode == 200) {
        // TODO: decide whether to parse data or if it's not needed (Only needed if prefill is required for kyc for edit KYC feature maybe?)
        FetchedKycData data;
        var responseData = response.response.data["data"] as Map<String, dynamic>; //TODO: revisit
        if (userIsCandidate() == true) {
          data = FetchedKycCandidateData.fromMap(responseData);
          
        } else {
          data = FetchedKycRecruiterData.fromMap(responseData);
        }
        emit(CheckKycAvailabilityFound(data: data));
      } else if (response.response.statusCode == 400) {
        emit(const CheckKycAvailabilityNotFound());
      } else {
        emit(const CheckKycAvailabilityErrorState(
            message: 'Something went wrong'));
      }
    } catch (e) {
      emit(const CheckKycAvailabilityErrorState(
          message: 'Something went wrong'));
    }
  }
    
  bool userIsCandidate() {
    return Global.userModel?.type == "user";
  }
}

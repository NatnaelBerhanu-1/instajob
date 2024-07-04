import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/get_payment_link_bloc/get_payment_link_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class GetPaymentLinkCubit extends Cubit<GetPaymentLinkState> {
  final JobPositionRepository jobPositionRepository;
  GetPaymentLinkCubit(this.jobPositionRepository)
      : super(GetPaymentLinkInitialState());

  Future<void> getPaymentLink(String user_id, String recruiter_id, double amount) async {
    emit(const GetPaymentLinkLoading());
    ApiResponse response = await jobPositionRepository.getPaymentLink(user_id, recruiter_id, amount);
    if (response.response.statusCode == 500) {
      emit(const GetPaymentLinkErrorState(message: 'Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      debugPrint('LOGGresponse ${response.response.data['data']}');
      var link = response.response.data['data'];

      emit(GetPaymentLinkLoaded(linkUrl: link));
    } else if (response.response.statusCode == 400) {
      emit(const GetPaymentLinkErrorState(message: "Data Not Found"));
    } else {
      emit(const GetPaymentLinkErrorState(message: 'Something went wrong'));
    }
  }
}

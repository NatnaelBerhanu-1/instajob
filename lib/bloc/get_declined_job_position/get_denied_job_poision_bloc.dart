import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/get_declined_job_position/get_denied_job_pos_state.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class GetDeniedJobPositionCubit extends Cubit<GetDeniedJobPosState> {
  final JobPositionRepository jobPositionRepository;
  GetDeniedJobPositionCubit(this.jobPositionRepository)
      : super(GetDeniedJobPosInitialState());
  JobPosModel jobModel = JobPosModel();

  Future<void> execute({String? jobId}) async {
    emit(const GetDeniedJobPosLoading());
    ApiResponse response = await jobPositionRepository.getDeniedCandidates(
        jobId: jobId, status: "denied");
    if (response.response.statusCode == 500) {
      emit(const GetDeniedJobPosErrorState(message: 'Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      debugPrint('response ${response.response.data['data']}');
      List<JobPosModel> list = (response.response.data['data'] as List)
          .map((e) => JobPosModel.fromJson(e).copyWith(jobId: jobId))
          .toList();

      emit(GetDeniedJobPosLoaded(
        declinedList: list,
      ));
    } else if (response.response.statusCode == 400) {
      emit(const GetDeniedJobPosErrorState(message: "Data Not Found"));
    } else {
      emit(const GetDeniedJobPosErrorState(message: 'Something went wrong'));
    }
  }
}

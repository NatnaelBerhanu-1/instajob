import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/get_hired_job_position/get_hired_candidates_state.dart';
import 'package:insta_job/model/hired_candidate.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class GetHiredCandidatesCubit extends Cubit<GetHiredCandidatesState> {
  final JobPositionRepository jobPositionRepository;
  GetHiredCandidatesCubit(this.jobPositionRepository)
      : super(GetHiredCandidatesInitialState());

  Future<void> execute() async {
    emit(const GetHiredCandidatesLoading());
    ApiResponse response = await jobPositionRepository.getHiredCandidates();
    if (response.response.statusCode == 500) {
      emit(const GetHiredJobPosErrorState(message: 'Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      debugPrint('LOGG get-hired response ${response.response.data['data']}');
      List<HiredCandidate> list = (response.response.data['data'] as List)
          .map((e) => HiredCandidate.fromJson(e))
          .toList();
      debugPrint('LOGG get-hired list $list');


      emit(GetHiredCandidatesLoaded(hiredList: list));
    } else if (response.response.statusCode == 400) {
      emit(const GetHiredJobPosErrorState(message: "Data Not Found"));
    } else {
      emit(const GetHiredJobPosErrorState(message: 'Something went wrong'));
    }
  }
}

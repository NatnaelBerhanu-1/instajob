import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/interview_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/interview_repo.dart';

class InterviewScheduleCubit extends Cubit<InterviewScheduleState> {
  final InterviewRepo repo;
  InterviewScheduleCubit(this.repo) : super(InterviewScheduleInitial());

  Future<void> getInterviewSchedules(String id) async {
    emit(InterviewScheduleLoading());
    // ApiResponse response = await repo.getInterviewSchedules(id);
    ApiResponse response;
    if (Global.userModel?.type == "user"){
      response = await repo.getInterviewSchedulesAsCandidate(id);
    } else {
      response = await repo.getInterviewSchedules(id);
    }

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(InterviewScheduleErrorState(message: "Server error. Something went wrong. Please try again."));
    }

    if (response.appStatusCode == AppStatusCode.success) {
      List<InterviewModel> interviews =
          (response.response.data['data'] as List).map((e) => InterviewModel.fromMap(e)).toList();
      emit(InterviewScheduleSuccess(
          upcomingSchedules: interviews.where((element) => element.statusCall == 'upcoming').toList(),
          pastSchedules: interviews.where((element) => element.statusCall == 'previous').toList()));
    } else {
      emit(InterviewScheduleErrorState(message: "Data not found"));
    }
  }
}

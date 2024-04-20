import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/interview_repo.dart';

class InterviewScheduleCubit extends Cubit<InterviewScheduleState> {
  final InterviewRepo repo;
  InterviewScheduleCubit(this.repo) : super(InterviewScheduleInitial());

  Future<void> getInterviewSchedules() async {
    emit(InterviewScheduleLoading());
    ApiResponse response = await repo.getInterviewSchedules();

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(InterviewScheduleErrorState(
          message: "Server error. Something went wrong. Please try again."));
    }
    if (response.appStatusCode == AppStatusCode.success) {
      emit(InterviewScheduleSuccess(
          upcomingSchedules: response.response["upcoming"],
          pastSchedules: response.response["previous"]));
    } else {
      emit(InterviewScheduleErrorState(message: "Data not found"));
    }
  }
}

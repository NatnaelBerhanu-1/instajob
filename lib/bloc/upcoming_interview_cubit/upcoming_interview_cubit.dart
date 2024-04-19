import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/upcoming_interview_cubit/upcoming_interview_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/interview_repo.dart';

class UpcomingInterviewCubit extends Cubit<UpcomingInterviewState> {
  final InterviewRepo repo;
  UpcomingInterviewCubit(this.repo) : super(UpcomingInterviewInitial());

  Future<void> getUpcomingInterviews() async {
    emit(UpcomingInterviewLoading());
    ApiResponse response = await repo.getUpcomingInterviews();

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(UpcomingInterviewErrorState(
          message: "Server error. Something went wrong. Please try again."));
    }
    if (response.appStatusCode == AppStatusCode.success) {
      emit(UpcomingInterviewSuccess());
    } else {
      emit(UpcomingInterviewErrorState(message: "Data not found"));
    }
  }
}

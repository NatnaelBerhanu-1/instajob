import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/previous_interviews_info/previous_interviews_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/interview_repo.dart';

class PreviousInterviewCubit extends Cubit<PreviousInterviewState> {
  final InterviewRepo repo;
  PreviousInterviewCubit(this.repo) : super(PreviousInterviewInitial());

  Future<void> getPreviousInterviews() async {
    emit(PreviousInterviewLoading());
    ApiResponse response = await repo.getPreviousInterviews();

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(PreviousInterviewErrorState(
          message: "Server error. Something went wrong. Please try again."));
    }
    if (response.appStatusCode == AppStatusCode.success) {
      emit(PreviousInterviewSuccess());
    } else {
      emit(PreviousInterviewErrorState(message: "Data not found"));
    }
  }
}

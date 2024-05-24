import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/cancel_interview_schedule_cubit/cancel_interview_schedule_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/interview_repo.dart';

class CancelInterviewScheduleCubit extends Cubit<CancelInterviewScheduleState> {
  final InterviewRepo repo;
  CancelInterviewScheduleCubit(this.repo) : super(CancelInterviewScheduleInitial());

  Future<void> cancelInterviewSchedule({required String callId, required String statusCall}) async {
    emit(CancelInterviewScheduleLoading(callId: callId));
    ApiResponse response = await repo.cancelInterviewSchedule(callId: callId, statusCall: statusCall);
      // await Future.delayed(Duration(seconds: 3));
      // emit(CancelInterviewScheduleSuccess());

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(CancelInterviewScheduleErrorState(message: "Server error. Something went wrong. Please try again."));
    } else if (response.appStatusCode == AppStatusCode.success) {
      emit(CancelInterviewScheduleSuccess());
    } else {
      emit(CancelInterviewScheduleErrorState(message: "Data not found"));
    }
  }
}

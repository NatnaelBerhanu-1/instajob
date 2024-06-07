import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/end_interview_call_cubit/end_interview_call_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/payload/end_call_recording_payload.dart';
import 'package:insta_job/payload/end_call_transcription_payload.dart';
import 'package:insta_job/repository/interview_repo.dart';

class EndInterviewCallScheduleCubit extends Cubit<EndInterviewCallScheduleState> {
  final InterviewRepo repo;
  EndInterviewCallScheduleCubit(this.repo) : super(EndInterviewCallScheduleInitial());

  Future<void> endInterviewCallSchedule({required String callId, required EndCallRecordingPayload? endCallRecordingPayload, required EndCallTranscriptionPayload? endCallTranscriptionPayload}) async {
    emit(EndInterviewCallScheduleLoading(callId: callId));
    ApiResponse response = await repo.endInterviewCallSchedule(callId: callId, endCallRecordingPayload: endCallRecordingPayload, endCallTranscriptionPayload: endCallTranscriptionPayload);

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(EndInterviewCallScheduleErrorState(message: "Server error. Something went wrong. Please try again."));
    } else if (response.appStatusCode == AppStatusCode.success) {
      emit(EndInterviewCallScheduleSuccess());
    } else {
      emit(EndInterviewCallScheduleErrorState(message: "Data not found"));
    }
  }
}


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/interview_transcription_cubit/interview_transcription_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class InterviewTranscriptionCubit extends Cubit<InterviewTranscriptionState> {
  final JobPositionRepository repo;
  InterviewTranscriptionCubit(this.repo) : super(InterviewTranscriptionInitial());

  String? builderToken = "";

  Future<void> startTranscription({required String? channelName}) async {
    emit(InterviewTranscriptionLoading());
    try {
      ApiResponse response = await repo.startTranscription(channelName: channelName);
      debugPrint("LOG:: transcription payload channelName -> $channelName");

      if (response.response.statusCode == 200) {
        // var temp = response.response.data[]
        var fetchedBuilderToken = response.response.data['data']['builder_token'];
        debugPrint("LOG:: transcription response builder token -> $fetchedBuilderToken");
        builderToken = fetchedBuilderToken;
        emit(InterviewStartTranscriptionSuccess());
      } else {
        emit(InterviewStartTranscriptionErrorState(message: "Something went wrong"));
      }

      
    } on DioException catch (e) {
      emit(InterviewStartTranscriptionErrorState(message: "Error! Something went wrong"));
    } catch (e) {
      emit(InterviewStartTranscriptionErrorState(message: "Error! Something went wrong"));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/interview_cubit/interview_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/interview_repo.dart';

class InterviewCubit extends Cubit<InterviewState> {
  final InterviewRepo interviewRepo;
  InterviewCubit(this.interviewRepo) : super(IntInitialState());

  uploadMp3File({required String file}) async {
    ApiResponse response = await interviewRepo.uploadMp3File(file: file);
    if (response.response.statusCode == 500) {
      emit(IntErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      showToast("SUCCESS");
    } else if (response.response.statusCode == 400) {
      emit(IntErrorState("Something went wrong"));
    }
  }
}

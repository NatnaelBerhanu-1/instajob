import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/resume_repo.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final ResumeRepository resumeRepository;
  getResumeData(String id) async {
    // ApiResponse response = await resumeRepository.
  }
  ResumeBloc(this.resumeRepository) : super(ResumeInitial()) {
    on<AddResumeEvent>((event, emit) async {
      ApiResponse response = await resumeRepository.addResume(
        name: event.resumeModel.yourName,
        passion: event.resumeModel.yourPassion,
        pWork: event.resumeModel.previousWork,
        skills: event.resumeModel.yourTop5Skills,
        phoneNumber: event.resumeModel.phoneNumber.toString(),
      );
    });
  }
}

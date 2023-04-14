import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class JobPositionBloc extends Bloc<JobPosEvent, JobPosState> {
  final JobPositionRepository jobPositionRepository;
  _getJobPositionList(Emitter emit) async {
    ApiResponse response = await jobPositionRepository.getJobPositions();
    if (response.response.statusCode == 500) {
      emit(const ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      List<JobPosModel> jobPosList = (response.response.data['data'] as List)
          .map((e) => JobPosModel.fromJson(e))
          .toList();
      emit(JobPosLoaded(jobPosList));
      return jobPosList;
    }
  }

  JobPositionBloc(this.jobPositionRepository) : super(JobPosInitialState()) {
    on<LoadJobPosListEvent>((event, emit) async {
      emit(JobPosLoading());
      var jobPosList = await _getJobPositionList(emit);
      emit(JobPosLoaded(jobPosList));
    });
    on<AddJobPositionEvent>((event, emit) async {
      await jobPositionRepository.addJobPosition(
        jobDetails: event.jobDetails,
        requirements: event.requirements,
        responsibility: event.responsibility,
        topSkills: event.topSkills,
        salaries: event.salaries,
        areaDistance: event.areaDistance,
        jobsType: event.jobsType,
        experienceLevel: event.experienceLevel,
        uploadPhoto: event.uploadPhoto,
        applicationReceivedSubject: event.applicationReceivedSubject,
        applicationReceivedContent: event.applicationReceivedContent,
        disqualifiedReviewSubject: event.disqualifiedReviewSubject,
        disqualifiedReviewContent: event.disqualifiedReviewContent,
        shortlistedReviewSubject: event.shortlistedReviewSubject,
        shortlistedReviewContent: event.shortlistedReviewContent,
      );
      _getJobPositionList(emit);
    });
  }
}

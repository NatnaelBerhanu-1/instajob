import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class JobPositionBloc extends Bloc<JobPosEvent, JobPosState> {
  final JobPositionRepository jobPositionRepository;
  _getJobPositionList(Emitter emit, {String? id}) async {
    ApiResponse response = await jobPositionRepository.getJobPositions(id: id);
    if (response.response.statusCode == 500) {
      emit(const JobErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      List<JobPosModel> jobPosList = (response.response.data['data'] as List)
          .map((e) => JobPosModel.fromJson(e))
          .toList();
      emit(JobPosLoaded(jobPosList));
      return jobPosList;
    } else {
      emit(const JobErrorState("Data not found"));
    }
  }

  _getSaveJobPosList(Emitter emit) async {
    ApiResponse response = await jobPositionRepository.getSavedJob();
    if (response.response.statusCode == 500) {
      emit(const JobErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      List<JobPosModel> jobPosList = (response.response.data['data'] as List)
          .map((e) => JobPosModel.fromJson(e))
          .toList();
      emit(JobPosLoaded(jobPosList));
      return jobPosList;
    } else {
      emit(const JobErrorState("Data not found"));
    }
  }

  JobPositionBloc(this.jobPositionRepository) : super(JobPosInitialState()) {
    on<LoadJobPosListEvent>((event, emit) async {
      emit(JobPosLoading());
      List<JobPosModel> jobPosList =
          await _getJobPositionList(emit, id: event.companyId);
      emit(JobPosLoaded(jobPosList));
      if (jobPosList.isEmpty) {
        emit(const JobErrorState("Data not found"));
      }
    });

    on<AddJobPositionEvent>((event, emit) async {
      if (event.isUpdate != true) {
        emit(JobPosLoading());
        ApiResponse response = await jobPositionRepository.addJobPosition(
          companyId: event.companyId,
          jobDetails: event.jobDetails,
          designation: event.designation,
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
        if (response.response.statusCode == 500) {
          emit(const JobErrorState("Something went wrong"));
        }
        if (response.response.statusCode == 200) {
          await _getJobPositionList(emit, id: event.companyId);
        } else if (response.response.statusCode == 400) {
          emit(const JobErrorState("Please fill all details"));
        }
      } else {
        ApiResponse response = await jobPositionRepository.updateJobPosition(
          id: event.id,
          isUpdate: true,
          designation: event.designation,
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
        if (response.response.statusCode == 500) {
          emit(const JobErrorState("Something went wrong"));
        }
        if (response.response.statusCode == 200) {
          await _getJobPositionList(emit, id: event.companyId);
        } else if (response.response.statusCode == 400) {
          emit(const JobErrorState("Please fill all details"));
        }
      }
    });

    on<SaveJobPositionEvent>((event, emit) async {
      emit(JobPosLoading());
      ApiResponse response =
          await jobPositionRepository.saveJob(jobId: event.jobId);
      if (response.response.statusCode == 500) {
        emit(const JobErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        await _getSaveJobPosList(emit);
      }
    });

    on<SavedJobPositionListEvent>((event, emit) async {
      emit(JobPosLoading());
      List<JobPosModel> jobPosList = await _getSaveJobPosList(emit);
      emit(JobPosLoaded(jobPosList));
      if (jobPosList.isEmpty) {
        emit(const JobErrorState("Data not found"));
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/applied_job_model.dart';
import 'package:insta_job/model/filter_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

class JobPositionBloc extends Bloc<JobPosEvent, JobPosState> {
  final JobPositionRepository jobPositionRepository;
  JobPosModel jobModel = JobPosModel();
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

  _getSearchJobs(Emitter emit, FilterModel filterModel) async {
    ApiResponse response = await jobPositionRepository.searchJobs(filterModel);
    if (response.response.statusCode == 500) {
      emit(const JobErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      List<JobPosModel> list = (response.response.data['data'] as List)
          .map((e) => JobPosModel.fromJson(e))
          .toList();
      emit(JobSearchLoaded(list));
      print('LISTTT ------------            $list');
      return list;
    } else if (response.response.statusCode == 400) {
      emit(const JobErrorState("Data Not Found"));
    } else {
      emit(const JobErrorState('Something went wrong'));
    }
  }

  _getAppliedJobs(Emitter emit) async {
    ApiResponse response = await jobPositionRepository.getAppliedJob();
    if (response.response.statusCode == 500) {
      emit(const ApplyErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      List<AppliedJobModel> list = (response.response.data['data'] as List)
          .map((e) => AppliedJobModel.fromJson(e))
          .toList();
      emit(AppliedJobLoaded(list));
      return list;
    } else if (response.response.statusCode == 400) {
      emit(const ApplyErrorState("Data Not Found"));
    } else {
      emit(const ApplyErrorState('Something went wrong'));
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
          List<JobPosModel> jobPosList =
              await _getJobPositionList(emit, id: event.companyId);
          emit(JobPosLoaded(jobPosList));
          // navigationKey.currentState?.pop();
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
          List<JobPosModel> jobPosList =
              await _getJobPositionList(emit, id: event.companyId);
          showToast("Job Position Updated Successfully", isError: true);
          // navigationKey.currentState?.pop();
          emit(JobPosLoaded(jobPosList));
        } else if (response.response.statusCode == 400) {
          emit(const JobErrorState("Please fill all details"));
        }
      }
    });

    on<SaveJobPositionEvent>((event, emit) async {
      emit(JobPosLoading());
      ApiResponse response = await jobPositionRepository.saveJob(
          jobId: event.jobId, jobStatus: event.jobStatus);
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

    on<DeleteJobPositionEvent>((event, emit) async {
      ApiResponse response =
          await jobPositionRepository.deleteJobPosition(jobId: event.jobId);
      if (response.response.statusCode == 500) {
        emit(const JobErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        print("DELETE SUCCESSFULLY");
      } else if (response.response.statusCode == 400) {
        emit(JobErrorState(response.response.data['message']));
      }
    });

    on<JobSearchEvent>((event, emit) async {
      emit(JobPosLoading());
      var jobList = await _getSearchJobs(emit, event.filterModel);
      emit(JobSearchLoaded(jobList));
      if (jobList.isEmpty) {
        emit(const JobErrorState("Data not found"));
      }
    });

    on<ApplyJobEvent>((event, emit) async {
      emit(JobPosLoading());
      ApiResponse response = await jobPositionRepository.applyForJob(
          jobId: event.jobId, resume: event.resume);
      if (response.response.statusCode == 500) {
        emit(const JobErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(const JobAppliedSuccessState());
      } else if (response.response.statusCode == 400) {
        emit(JobErrorState(response.response.data['message']));
      }
    });

    on<AppliedJobListEvent>((event, emit) async {
      emit(ApplyLoading());
      List<AppliedJobModel> appliedJobList = await _getAppliedJobs(emit);
      emit(AppliedJobLoaded(appliedJobList));
    });

    on<SortListOrDenyEvent>((event, emit) async {
      ApiResponse response =
          await jobPositionRepository.shortlistOrDenied(id: event.id);
      if (response.response.statusCode == 500) {
        emit(const JobErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(SortListDenyState());
      } else if (response.response.statusCode == 400) {
        emit(JobErrorState(response.response.data['message']));
      }
    });
  }
}

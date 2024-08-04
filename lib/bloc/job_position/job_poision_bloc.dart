import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/filter_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/end_points.dart';
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
      List<JobPosModel> jobPosList =
          (response.response.data['data'] as List).map((e) => JobPosModel.fromJson(e)).toList();
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
      List<JobPosModel> jobPosList = (response.response.data['data'] as List).map((e) {
        debugPrint('Data: $e');
        var item = JobPosModel.fromJson(e).copyWith(jobStatus: 1, jobId: e['job_id'].toString(), id: e['job_id']);
        debugPrint('ID:${item.id}, ${item.jobId}');
        return item;
      }).toList();
      emit(SaveJobPosLoaded(jobPosList));
      return jobPosList;
    } else {
      emit(const JobErrorState("Data not found"));
    }
  }

  _getSearchJobs(Emitter emit, FilterModel filterModel) async {
    emit(JobPosLoading());
    ApiResponse response = await jobPositionRepository.searchJobs(filterModel);
    if (response.response.statusCode == 500) {
      emit(const JobErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      List<JobPosModel> list = (response.response.data['data'] as List).map((e) => JobPosModel.fromJson(e)).toList();
      emit(JobSearchLoaded(list));
      print('LISTTT ------------            $list');
      return list;
    } else if (response.response.statusCode == 400) {
      emit(const JobErrorState("Data Not Found"));
    } else {
      emit(const JobErrorState('Something went wrong'));
    }
  }

  List<JobDistanceModel> jobDistanceList = [];
  _getJobDistanceLocator(Emitter emit, {String? designation, String? miles, double? lat, double? long}) async {
    ApiResponse response = await jobPositionRepository.jobDistanceLocator(designation: designation, miles: miles, lat: lat, long: long);
    if (response.response.statusCode == 500) {
      emit(const JobErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      List<JobDistanceModel> jobDistanceList = (response.response.data['data'] as List).map((e) => JobPosModel.fromJson(e)).toList().map((item) {
        return JobDistanceModel(
          id: item.id,
          jobSaved: item.jobStatus,
          companyname: item.companyName,
          companyUploadPhoto: item.uploadPhoto,
          cAddress: item.cAddress,
          cLat: item.cLat,
          cLog: item.cLog,
          designation: item.designation,
          salaries: item.salaries,
          areaDistance: item.areaDistance,
          jobsType: item.jobsType,
          experienceLevel: item.experienceLevel,

        );
      }).toList();
      List<JobDistanceModel> filteredJobs = filterJobPositionsByRadius(jobDistanceList, lat, long, miles);
      jobDistanceList = filteredJobs;
      print('JOB LIST ------------            $jobDistanceList');
      return jobDistanceList;
    } else if (response.response.statusCode == 400) {
      emit(const JobErrorState("Data Not Found"));
    } else {
      emit(const JobErrorState('Something went wrong'));
    }
  }

  _getAppliedJobs(Emitter emit, {String? jobId, String? status}) async {
    emit(ApplyLoading());
    debugPrint('JobId:$jobId');
    ApiResponse response = await jobPositionRepository.getAppliedJob(jobId: jobId, status: status);
    if (response.response.statusCode == 500) {
      emit(const ApplyErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      debugPrint('response ${response.response.data['data']}');
      List<JobPosModel> list =
          (response.response.data['data'] as List).map((e) => JobPosModel.fromJson(e).copyWith(jobId: jobId)).toList();

      // Defining lists for filtering
      List<JobPosModel> appliedOnly = [];
      List<JobPosModel> shortlisted = [];

      for (JobPosModel job in list) {
        // Filter based on candidateStatus
        debugPrint('UploadResume: ${job.uploadResume}');
        if (job.candidateStatus == "applied") {
          // Add to appliedOnly list
          appliedOnly.add(job);
        } else if (job.candidateStatus == "shortlisted") {
          // Add to shortlisted list
          shortlisted.add(job);
        }
      }
      emit(AppliedJobLoaded(
        appliedJobList: list,
        appliedOnly: appliedOnly,
        shortlisted: shortlisted,
      ));
      // List<JobPosModel> _appliedOnly = [];
      // List<JobPosModel> _shortlisted = [];
      // // iterate over the list and get the score
      // var requests = <Future<int>>[];
      // for (JobPosModel job in list) {
      //   requests.add(jobPositionRepository.getJobMatchScore(
      //       job.userId!, job.jobDetails!, "${EndPoint.imageBaseUrl}${job.uploadResume}"));
      // }
      // try {
      //   var result = await Future.wait(requests, eagerError: true);
      //   for (var i = 0; i < result.length; i++) {
      //     var score = result[i];
      //     list[i].matchScore = score;
      //     // Filter based on candidateStatus
      //     if (list[i].candidateStatus == "applied") {
      //       // Add to appliedOnly list
      //       _appliedOnly.add(list[i]);
      //     } else if (list[i].candidateStatus == "shortlisted") {
      //       // Add to shortlisted list
      //       _shortlisted.add(list[i]);
      //     }
      //   }
      //   debugPrint('State[NewState]: $state');
      //   if (state is AppliedJobLoaded) {
      //     emit(AppliedJobLoaded(
      //       appliedJobList: list,
      //       appliedOnly: _appliedOnly,
      //       shortlisted: _shortlisted,
      //     ));
      //   }
      // } catch (e, stk) {
      //   debugPrintStack(stackTrace: stk);
      //   emit(const ApplyErrorState('Something went wrong'));
      // }

      //todo: add another emit loaded state after checking resume matcher endpoint
      // return list; //delete return
    } else if (response.response.statusCode == 400) {
      emit(const ApplyErrorState("Data Not Found"));
    } else {
      emit(const ApplyErrorState('Something went wrong'));
    }
  }

  JobPositionBloc(this.jobPositionRepository) : super(JobPosInitialState()) {
    on<LoadJobPosListEvent>((event, emit) async {
      emit(JobPosLoading());
      try {
        List<JobPosModel> jobPosList = await _getJobPositionList(emit, id: event.companyId);
        emit(JobPosLoaded(jobPosList));
        if (jobPosList.isEmpty) {
          emit(const JobErrorState("Data not found"));
        }
      } catch(e) {
        emit(const JobErrorState("Something happened. Try again later")); //TODO: revisit(maybe add a button)
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
          List<JobPosModel> jobPosList = await _getJobPositionList(emit, id: event.companyId);
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
          List<JobPosModel> jobPosList = await _getJobPositionList(emit, id: event.companyId);
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
      ApiResponse response = await jobPositionRepository.saveJob(jobId: event.jobId, jobStatus: event.jobStatus);
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
      emit(SaveJobPosLoaded(jobPosList));
      if (jobPosList.isEmpty) {
        emit(const JobErrorState("Data not found"));
      }
    });

    on<DeleteJobPositionEvent>((event, emit) async {
      ApiResponse response = await jobPositionRepository.deleteJobPosition(jobId: event.jobId);
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
      // if (jobList.isEmpty) {
      //   emit(const JobErrorState("Data not found"));
      // }
      // emit(JobPosInitialState());
    });

    on<JobDistanceLocatorEvent>((event, emit) async {
      emit(JobPosLoading());
      jobDistanceList = await _getJobDistanceLocator(emit, miles: event.miles, designation: event.designation, lat: event.lat, long: event.long);
      emit(JobDistanceLoaded(jobDistanceList));
      // emit(JobPosInitialState());
    });

    on<ApplyJobEvent>((event, emit) async {
      emit(JobPosLoading());
      ApiResponse response = await jobPositionRepository.applyForJob(jobId: event.jobId, resume: event.resume);
      if (response.response.statusCode == 500) {
        emit(const JobErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(const JobAppliedSuccessState());
      } else if (response.response.statusCode == 400) {
        emit(JobErrorState(response.response.data['message']));
      }
    });

    on<AppliedJobListEvent>((event, emit) => _getAppliedJobs(emit, jobId: event.jobId, status: event.status));

    on<SortListOrDenyEvent>((event, emit) async {
      if (event.shortListOrDenyAction == ShortListOrDenyAction.shortlist) {
        debugPrint("LOG shortlist loading");
        emit(ShorlistLoading());
      } else {
        debugPrint("LOG deny loading");
        emit(DenyLoading());
      }
      try {
        ApiResponse response = await jobPositionRepository.shortlistOrDenied(
            appliedListId: event.appliedListId, status: event.status); //TODO: get status from shortListOrDenyAction
        if (response.response.statusCode == 500) {
          debugPrint("LOG shortlist or deny 500");
          emit(const JobErrorState("Something went wrong"));
        } else if (response.response.statusCode == 200) {
          debugPrint("LOG shortlist or deny 200");
          emit(SortListDenyState());
        } else if (response.response.statusCode == 400) {
          debugPrint("LOG shortlist or deny 400");
          emit(JobErrorState(response.response.data['message']));
        } else {
          debugPrint("LOG shortlist or deny else");
          emit(JobErrorState(response.response.data['message']));
        }
      } catch(e) {
          debugPrint("LOG shortlist or deny catch error");
          emit(const JobErrorState("Something happened!"));
      }
    });

    on<HireCandidateEvent>((event, emit) async {
      emit(HireLoading());
      try {
        debugPrint("LOG hire candidate loading");
        ApiResponse response = await jobPositionRepository.hireCandidate(
            appliedListId: event.appliedListId);
        debugPrint("LOG hire candidate request completed");
        if (response.response.statusCode == 500) {
          debugPrint("LOG hire candidate 500");
          emit(const JobErrorState("Something went wrong"));
        } else if (response.response.statusCode == 200) {
          debugPrint("LOG hire candidate 200");
          emit(SortListDenyState()); //TODO: REVISIT //leaving this the same as ShortListDenyState to have the same refresh calls as the ShortListOrDeny functionality
        } else if (response.response.statusCode == 400) {
          debugPrint("LOG hire candidate 400");
          emit(JobErrorState(response.response.data['message']));
        } else {
          debugPrint("LOG hire candidate error else");
          emit(JobErrorState(response.response.data['message']));
        }
      } catch(e) {
        debugPrint("hire candidate error catch");
        emit(const JobErrorState("Error! Something happened"));
      }
    });

    on<SetInterviewEvent>((event, emit) async {
      emit(SetInterviewSlotLoading());
      ApiResponse response = await jobPositionRepository.setInterview(
          userId: event.userId,
          jobId: event.jobId,
          companyId: event.companyId,
          employeeId: event.employeeId,
          time: event.time,
          timeType: event.timeType,
          channelName:event.channelName,
          );
      if (response.response.statusCode == 500) {
        emit(const JobErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        navigationKey.currentState?.pop();
        emit(const SetInterviewSuccess());
      } else if (response.response.statusCode == 400) {
        emit(JobErrorState(response.response.data['message']));
      } else {
        emit(const JobErrorState("Error! Something went wrong"));
      }
    });
  }
  
  List<JobDistanceModel> filterJobPositionsByRadius(List<JobDistanceModel> jobDistanceList, double? currLat, double? currLong, String? miles) {    
    if (miles == null) {
      return jobDistanceList;
    }

    final milesDouble = double.tryParse(miles);
    if (milesDouble == null) {
      return jobDistanceList;
    }

    List<JobDistanceModel> filteredPositions = [];

    for (var currJob in jobDistanceList) {
      if (currLat == null || currLong == null || currJob.cLat == null || currJob.cLog == null) {
        continue;
      }

      final currJobLatDouble = double.tryParse(currJob.cLat!);
      final currJobLongDouble = double.tryParse(currJob.cLog!);
      final currJobAreaDistanceDouble = double.tryParse(currJob.areaDistance!); //TODO: double check
      if (currJobLatDouble == null || currJobLongDouble == null) {
        continue;
      }

      double distance = calculateDistance(
         currLat, currLong, currJobLatDouble, currJobLongDouble);
      // if (distance <= milesDouble * 1.60934) { //radius
      // if (distance <= milesDouble) { //radius
      if (distance <= milesDouble && distance <= currJobAreaDistanceDouble!) { //radius, //TODO: 
        filteredPositions.add(currJob.copyWith(distanceFromCurrUser: double.parse(distance.toStringAsFixed(2))));
      }
    }

    var res = filteredPositions;

    return filteredPositions;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers
    final lat1Radians = degreesToRadians(lat1);
    final lon1Radians = degreesToRadians(lon1);
    final lat2Radians = degreesToRadians(lat2);
    final lon2Radians = degreesToRadians(lon2);
    
    final dLat = lat2Radians - lat1Radians;
    final dLon = lon2Radians - lon1Radians;
    
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return R * c;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}

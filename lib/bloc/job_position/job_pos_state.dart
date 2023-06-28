import 'package:equatable/equatable.dart';
import 'package:insta_job/model/applied_job_model.dart';

import '../../model/job_position_model.dart';

class JobPosState extends Equatable {
  const JobPosState();
  @override
  List<Object?> get props => [];
}

class JobPosInitialState extends JobPosState {}

class JobPosLoading extends JobPosState {}

class ApplyLoading extends JobPosState {}

class SortListDenyState extends JobPosState {}

class JobPosLoaded extends JobPosState {
  final List<JobPosModel> jobPosList;

  const JobPosLoaded(this.jobPosList);
}

class JobSearchLoaded extends JobPosState {
  final List<JobPosModel> searchJobPosList;

  const JobSearchLoaded(this.searchJobPosList);
}

class JobDistanceLoaded extends JobPosState {
  final List<JobDistanceModel> jobList;

  const JobDistanceLoaded(this.jobList);
}

class AppliedJobLoaded extends JobPosState {
  final List<AppliedJobModel> appliedJobList;

  const AppliedJobLoaded(this.appliedJobList);
}

class JobErrorState extends JobPosState {
  final String error;

  const JobErrorState(this.error);
  @override
  List<Object?> get props => [];
}

class ApplyErrorState extends JobPosState {
  final String error;

  const ApplyErrorState(this.error);
  @override
  List<Object?> get props => [];
}

class JobAppliedSuccessState extends JobPosState {
  const JobAppliedSuccessState();
  @override
  List<Object?> get props => [];
}

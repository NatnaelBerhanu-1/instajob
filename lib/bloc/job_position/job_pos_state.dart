import 'package:equatable/equatable.dart';

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
class SaveJobPosLoaded extends JobPosState {
  final List<JobPosModel> jobPosList;

  const SaveJobPosLoaded(this.jobPosList);
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
  final List<JobPosModel> appliedJobList;
  final List<JobPosModel> appliedOnly;
  final List<JobPosModel> shortlisted;

  const AppliedJobLoaded({
    required this.appliedJobList,
    required this.appliedOnly,
    required this.shortlisted,
  });
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

class SetInterviewSuccess extends JobPosState {
  const SetInterviewSuccess();
  @override
  List<Object?> get props => [];
}

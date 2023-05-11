import 'package:equatable/equatable.dart';

import '../../model/job_position_model.dart';

class JobPosState extends Equatable {
  const JobPosState();
  @override
  List<Object?> get props => [];
}

class JobPosInitialState extends JobPosState {}

class JobPosLoading extends JobPosState {}

class JobPosLoaded extends JobPosState {
  final List<JobPosModel> jobPosList;

  const JobPosLoaded(this.jobPosList);
}

class JobErrorState extends JobPosState {
  final String error;

  const JobErrorState(this.error);
  @override
  List<Object?> get props => [];
}

class JobAppliedSuccessState extends JobPosState {
  const JobAppliedSuccessState();
  @override
  List<Object?> get props => [];
}

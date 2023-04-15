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

class ErrorState extends JobPosState {
  final String error;

  const ErrorState(this.error);
  @override
  List<Object?> get props => [];
}

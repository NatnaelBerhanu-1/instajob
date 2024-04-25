import 'dart:math';

import 'package:equatable/equatable.dart';

import '../../model/job_position_model.dart';

class GetDeniedJobPosState extends Equatable {
  const GetDeniedJobPosState();
  @override
  List<Object?> get props => [];
}

class GetDeniedJobPosInitialState extends GetDeniedJobPosState {}

class GetDeniedJobPosLoading extends GetDeniedJobPosState {
  const GetDeniedJobPosLoading();
}

class GetDeniedJobPosLoaded extends GetDeniedJobPosState {
  final List<JobPosModel> declinedList;

  const GetDeniedJobPosLoaded({
    required this.declinedList,
  });

  @override
  List<Object?> get props => [declinedList, Random()];
}

class GetDeniedJobPosErrorState extends GetDeniedJobPosState {
  final String message;

  const GetDeniedJobPosErrorState({
    required this.message,
  });
}

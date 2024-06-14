import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:insta_job/model/hired_candidate.dart';

class GetHiredCandidatesState extends Equatable {
  const GetHiredCandidatesState();
  @override
  List<Object?> get props => [];
}

class GetHiredCandidatesInitialState extends GetHiredCandidatesState {}

class GetHiredCandidatesLoading extends GetHiredCandidatesState {
  const GetHiredCandidatesLoading();
}

class GetHiredCandidatesLoaded extends GetHiredCandidatesState {
  final List<HiredCandidate> hiredList;

  const GetHiredCandidatesLoaded({
    required this.hiredList,
  });

  @override
  List<Object?> get props => [hiredList, Random()];
}

class GetHiredJobPosErrorState extends GetHiredCandidatesState {
  final String message;

  const GetHiredJobPosErrorState({
    required this.message,
  });
}

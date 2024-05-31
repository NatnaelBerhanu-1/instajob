import 'package:equatable/equatable.dart';

abstract class InterviewRecordingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterviewRecordingInitial extends InterviewRecordingState {}

class InterviewRecordingLoading extends InterviewRecordingState {}

class InterviewStartRecordingSuccess extends InterviewRecordingState {
  InterviewStartRecordingSuccess();
  @override
  List<Object?> get props => [];
}

class InterviewStopRecordingSuccess extends InterviewRecordingState {
  InterviewStopRecordingSuccess();
  @override
  List<Object?> get props => [];
}

class InterviewStartRecordingErrorState extends InterviewRecordingState {
  final String message;

  InterviewStartRecordingErrorState({
    required this.message,
  });
}

class InterviewStopRecordingErrorState extends InterviewRecordingState {
  final String message;

  InterviewStopRecordingErrorState({
    required this.message,
  });
}

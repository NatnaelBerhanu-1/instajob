import 'package:equatable/equatable.dart';

abstract class InterviewTranscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterviewTranscriptionInitial extends InterviewTranscriptionState {}

class InterviewTranscriptionLoading extends InterviewTranscriptionState {}

class InterviewStartTranscriptionSuccess extends InterviewTranscriptionState {
  InterviewStartTranscriptionSuccess();
  @override
  List<Object?> get props => [];
}

class InterviewStartTranscriptionErrorState extends InterviewTranscriptionState {
  final String message;

  InterviewStartTranscriptionErrorState({
    required this.message,
  });
}

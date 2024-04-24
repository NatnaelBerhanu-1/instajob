import 'package:equatable/equatable.dart';

abstract class PreviousInterviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreviousInterviewInitial extends PreviousInterviewState {}

class PreviousInterviewLoading extends PreviousInterviewState {}

class PreviousInterviewSuccess extends PreviousInterviewState {
  PreviousInterviewSuccess();
  @override
  List<Object?> get props => [];
}

class PreviousInterviewErrorState extends PreviousInterviewState {
  final String message;

  PreviousInterviewErrorState({
    required this.message,
  });
}

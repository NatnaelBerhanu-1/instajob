import 'package:equatable/equatable.dart';

abstract class UpcomingInterviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpcomingInterviewInitial extends UpcomingInterviewState {}

class UpcomingInterviewLoading extends UpcomingInterviewState {}

class UpcomingInterviewSuccess extends UpcomingInterviewState {
  UpcomingInterviewSuccess();
  @override
  List<Object?> get props => [];
}

class UpcomingInterviewErrorState extends UpcomingInterviewState {
  final String message;

  UpcomingInterviewErrorState({
    required this.message,
  });
}

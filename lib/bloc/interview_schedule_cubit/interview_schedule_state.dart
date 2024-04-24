import 'package:equatable/equatable.dart';

abstract class InterviewScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterviewScheduleInitial extends InterviewScheduleState {}

class InterviewScheduleLoading extends InterviewScheduleState {}

class InterviewScheduleSuccess extends InterviewScheduleState {
  InterviewScheduleSuccess({
    required this.upcomingSchedules,
    required this.pastSchedules,
  });
  final List<dynamic> upcomingSchedules; //TODO: urgent (replace dynamic)
  final List<dynamic> pastSchedules; //TODO: urgent (replace dynamic)
  @override
  List<Object?> get props => [];
}

class InterviewScheduleErrorState extends InterviewScheduleState {
  final String message;

  InterviewScheduleErrorState({
    required this.message,
  });
}

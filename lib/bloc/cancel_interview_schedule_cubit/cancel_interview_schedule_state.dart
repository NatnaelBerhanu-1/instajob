import 'package:equatable/equatable.dart';

abstract class CancelInterviewScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CancelInterviewScheduleInitial extends CancelInterviewScheduleState {}

class CancelInterviewScheduleLoading extends CancelInterviewScheduleState {}

class CancelInterviewScheduleSuccess extends CancelInterviewScheduleState {}

class CancelInterviewScheduleErrorState extends CancelInterviewScheduleState {
  final String message;

  CancelInterviewScheduleErrorState({
    required this.message,
  });
}

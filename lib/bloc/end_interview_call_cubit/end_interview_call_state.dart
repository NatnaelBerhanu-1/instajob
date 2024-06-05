import 'package:equatable/equatable.dart';

abstract class EndInterviewCallScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EndInterviewCallScheduleInitial extends EndInterviewCallScheduleState {}

class EndInterviewCallScheduleLoading extends EndInterviewCallScheduleState {
  final String callId;

  EndInterviewCallScheduleLoading({required this.callId});

}

class EndInterviewCallScheduleSuccess extends EndInterviewCallScheduleState {}

class EndInterviewCallScheduleErrorState extends EndInterviewCallScheduleState {
  final String message;

  EndInterviewCallScheduleErrorState({
    required this.message,
  });
}

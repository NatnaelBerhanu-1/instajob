import 'package:equatable/equatable.dart';
import 'package:insta_job/model/resume_model.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();
  @override
  List<Object?> get props => [];
}

class ResumeInitial extends ResumeState {}

// class CheckReadOnly extends ResumeState {
//   final bool readOnly;
//
//   const CheckReadOnly(this.readOnly);
// }
//
// class CheckConfirm extends ResumeState {
//   final bool val;
//
//   const CheckConfirm(this.val);
// }
//
// class PhoneState extends ResumeState {}
//
// class PassionState extends ResumeState {}
//
// class PWorkState extends ResumeState {}

class ResumeLoaded extends ResumeState {
  final ResumeModel resumeModel;

  const ResumeLoaded({required this.resumeModel});
}

class ErrorState extends ResumeState {
  final String error;

  const ErrorState(this.error);
}

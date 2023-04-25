import 'package:equatable/equatable.dart';
import 'package:insta_job/model/resume_model.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();
  @override
  List<Object?> get props => [];
}

class ResumeInitial extends ResumeState {}

class ResumeLoaded extends ResumeState {
  final ResumeModel resumeModel;

  const ResumeLoaded({required this.resumeModel});
}

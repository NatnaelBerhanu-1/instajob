import 'package:equatable/equatable.dart';
import 'package:insta_job/model/resume_detail_model.dart';

abstract class ResumeDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResumeDetailsInitial extends ResumeDetailsState {}

class ResumeDetailsLoading extends ResumeDetailsState {}

class ResumeDetailsSuccess extends ResumeDetailsState {
  final ResumeDetailModel resumeDetail;

  ResumeDetailsSuccess({
    required this.resumeDetail,
  });
  @override
  List<Object?> get props => [resumeDetail];
}

class ResumeDetailsErrorState extends ResumeDetailsState {
  final String message;

  ResumeDetailsErrorState({
    required this.message,
  });
}

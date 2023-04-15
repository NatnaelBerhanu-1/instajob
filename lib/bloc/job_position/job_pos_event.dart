import 'package:equatable/equatable.dart';

abstract class JobPosEvent extends Equatable {}

class LoadJobPosListEvent extends JobPosEvent {
  @override
  List<Object?> get props => [];
}

class AddJobPositionEvent extends JobPosEvent {
  final String? jobDetails;
  final String? requirements;
  final String? responsibility;
  final String? topSkills;
  final String? salaries;
  final String? areaDistance;
  final String? jobsType;
  final String? experienceLevel;
  final String? uploadPhoto;
  final String? applicationReceivedSubject;
  final String? applicationReceivedContent;
  final String? disqualifiedReviewSubject;
  final String? disqualifiedReviewContent;
  final String? shortlistedReviewSubject;
  final String? shortlistedReviewContent;

  AddJobPositionEvent(
      {this.jobDetails,
      this.requirements,
      this.responsibility,
      this.topSkills,
      this.salaries,
      this.areaDistance,
      this.jobsType,
      this.experienceLevel,
      this.uploadPhoto,
      this.applicationReceivedSubject,
      this.applicationReceivedContent,
      this.disqualifiedReviewSubject,
      this.disqualifiedReviewContent,
      this.shortlistedReviewSubject,
      this.shortlistedReviewContent});
  @override
  List<Object?> get props => [];
}

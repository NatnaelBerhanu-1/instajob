import 'package:equatable/equatable.dart';

abstract class JobPosEvent extends Equatable {}

class LoadJobPosListEvent extends JobPosEvent {
  final String companyId;
  LoadJobPosListEvent({this.companyId = ""});
  @override
  List<Object?> get props => [];
}

class AddJobPositionEvent extends JobPosEvent {
  final String? companyId;
  final String? id;
  final bool? isUpdate;
  final String? designation;
  final String? jobDetails;
  final String? requirements;
  final String? responsibility;
  final List<String>? topSkills;
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
      {this.companyId,
      this.jobDetails,
      this.requirements,
      this.designation,
      this.responsibility,
      this.topSkills,
      this.id,
      this.isUpdate,
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

class SaveJobPositionEvent extends JobPosEvent {
  final String jobId;
  final String userId;

  SaveJobPositionEvent({required this.jobId, required this.userId});
  @override
  List<Object?> get props => [];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:insta_job/model/filter_model.dart';

abstract class JobPosEvent extends Equatable {}

class LoadJobPosListEvent extends JobPosEvent {
  final String? companyId;
  LoadJobPosListEvent({this.companyId});
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
  final String jobStatus;

  SaveJobPositionEvent({required this.jobId, required this.jobStatus});
  @override
  List<Object?> get props => [];
}

class DeleteJobPositionEvent extends JobPosEvent {
  final String jobId;

  DeleteJobPositionEvent({required this.jobId});
  @override
  List<Object?> get props => [];
}

class ApplyJobEvent extends JobPosEvent {
  final String jobId;
  final String resume;

  ApplyJobEvent(this.resume, {required this.jobId});
  @override
  List<Object?> get props => [];
}

class AppliedJobListEvent extends JobPosEvent {
  final String? jobId;
  final String? status;
  AppliedJobListEvent({this.jobId, this.status});
  @override
  List<Object?> get props => [];
}

class SavedJobPositionListEvent extends JobPosEvent {
  @override
  List<Object?> get props => [];
}

class JobSearchEvent extends JobPosEvent {
  final FilterModel filterModel;

  JobSearchEvent({required this.filterModel});
  @override
  List<Object?> get props => [];
}

class JobDistanceLocatorEvent extends JobPosEvent {
  final String? designation;
  final String? miles;
  JobDistanceLocatorEvent({this.designation, this.miles});
  @override
  List<Object?> get props => [];
}

enum ShortListOrDenyAction {
  shortlist,
  denied,
}

class SortListOrDenyEvent extends JobPosEvent {
  final String appliedListId;
  final String? status;
  final ShortListOrDenyAction shortListOrDenyAction;

  SortListOrDenyEvent(
      {required this.appliedListId,
      this.status,
      required this.shortListOrDenyAction,});
  @override
  List<Object?> get props => [];
}

class SetInterviewEvent extends JobPosEvent {
  final String? companyId;
  final String? employeeId;
  final String? jobId;
  final String? userId;
  final String? time;
  final String? timeType;

  SetInterviewEvent({this.companyId, this.employeeId, this.jobId, this.userId, this.time, this.timeType});
  @override
  List<Object?> get props => [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'employeeId': employeeId,
      'jobId': jobId,
      'userId': userId,
      'time': time,
      'timeType': timeType,
    };
  }

  String toJson() => json.encode(toMap());
}

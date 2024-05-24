// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/model/user_model.dart';

class InterviewModel {
  final int id;
  final int companyId;
  final int employeeId;
  final int jobId;
  final int userId;
  final Timestamp time;
  final String timeType;
  final String statusCall;
  final String? callRecording;
  final UserModel? user;
  final UserModel? recruiter;
  final JobPosModel? job;
  final String? token;
  final String? channelName;
  InterviewModel({
    required this.id,
    required this.companyId,
    required this.employeeId,
    required this.jobId,
    required this.userId,
    required this.time,
    required this.timeType,
    required this.statusCall,
    required this.token,
    required this.channelName,
    this.callRecording,
    this.user,
    this.recruiter,
    this.job,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'employeeId': employeeId,
      'jobId': jobId,
      'userId': userId,
      'time': time.toDate().toIso8601String(),
      'timeType': timeType,
      'statusCall': statusCall,
      'callRecording': callRecording,
      'user': user?.toJson(),
      'recruiter': recruiter?.toJson(),
      'job': job?.toJson(),
      'token': token,
      'channelName': channelName,
    };
  }

  factory InterviewModel.fromMap(Map<String, dynamic> map) {
    return InterviewModel(
        id: map['id'] as int,
        companyId: map['company_id'] as int,
        employeeId: map['employee_id'] as int,
        jobId: map['job_id'] as int,
        userId: map['user_id'] as int,
        time: Timestamp.fromDate(DateTime.parse(map['time'])),
        timeType: map['time_type'] as String,
        statusCall: map['status_call'] as String,
        callRecording: map['call_recording'] != null ? map['call_ecording'] as String : null,
        user: map['user'] != null ? UserModel.fromJson(map['user'] as Map<String, dynamic>) : null,
        recruiter: map['recruiter'] != null ? UserModel.fromJson(map['recruiter'] as Map<String, dynamic>) : null,
        job: map['job'] != null ? JobPosModel.fromJson(map['job'] as Map<String, dynamic>) : null,
        token: map['token'] != null ? map['token'] as String: "",
        channelName: map['channel_name'] != null ? map['channel_name'] as String : "");
  }

  String toJson() => json.encode(toMap());

  factory InterviewModel.fromJson(String source) => InterviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

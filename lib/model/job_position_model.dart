// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class JobPosModel {
  int? id;
  int? userId;
  int? appliedId;
  String? userFirebaseId;
  int? companyId;
  String? designation;
  String? companyName;
  String? userName;
  int? jobStatus;
  int? empId;
  String? empFirebase;
  String? empName;
  String? cAddress;
  String? cLat;
  String? cLog;
  String? jobDetails;
  String? requirements;
  String? responsibilities;
  List<String>? topSkills;
  String? salaries;
  String? userEmail;
  String? areaDistance;
  String? jobsType;
  String? experienceLevel;
  String? uploadPhoto;
  String? uploadResume;
  String? candidateStatus;
  String? applicationReceivedSubject;
  String? applicationReceivedContent;
  String? disqualifiedReviewSubject;
  String? disqualifiedReviewContent;
  String? shortlistedReviewSubject;
  String? shortlistedReviewContent;
  String? createdAt;
  String? updatedAt;
  int? matchScore;
  String? jobId;
  String? redirectionUrl;

  JobPosModel(
      {this.id,
      this.userId,
      this.companyId,
      this.appliedId,
      this.userFirebaseId,
      this.designation,
      this.jobDetails,
      this.companyName,
      this.userName,
      this.jobStatus,
      this.empId,
      this.empFirebase,
      this.empName,
      this.requirements,
      this.responsibilities,
      this.topSkills,
      this.salaries,
      this.areaDistance,
      this.jobsType,
      this.experienceLevel,
      this.uploadPhoto,
      this.uploadResume,
      this.candidateStatus,
      this.applicationReceivedSubject,
      this.applicationReceivedContent,
      this.disqualifiedReviewSubject,
      this.disqualifiedReviewContent,
      this.shortlistedReviewSubject,
      this.shortlistedReviewContent,
      this.createdAt,
      this.updatedAt,
      this.matchScore,
      this.jobId,
      this.redirectionUrl});

  JobPosModel.fromJson(Map<String, dynamic> json) {
    try {
      topSkills = List<String>.from(jsonDecode(json['Topskills']));
    } catch(e) {
      topSkills = [];
    }

    id = json['id'];
    jobId = json['id'].toString();
    userId = json['user_id'];
    companyId = json['company_id'];
    appliedId = json['applied_id'];
    userFirebaseId = json['user_firebase_id'];
    designation = json['designation'];
    companyName = json['companyname'];
    userName = json['name'];
    userEmail = json['email'];
    empId = json['emp_id'];
    empFirebase = json['emp_firebase'];
    empName = json['emp_name'];
    jobStatus = json['job_saved'];
    jobDetails = json['jobdetails'];
    cAddress = json['c_address'];
    cLat = json['c_lat'];
    cLog = json['c_log'];
    requirements = json['Requirements'];
    responsibilities = json['Responsilibites'];
    topSkills = topSkills;
    salaries = json['salaries'];
    areaDistance = json['Area_Distance'];
    jobsType = json['jobs_Type'];
    experienceLevel = json['Experience_level'];
    uploadPhoto = json['upload_photo'];
    uploadResume = json['upload_resume'];
    candidateStatus = json['status'].toString();
    // userProfile = json['upload_photo'];
    applicationReceivedSubject = json['Application_Received_subject'];
    applicationReceivedContent = json['Application_Received_content'];
    disqualifiedReviewSubject = json['Disqualified_review_subject'];
    disqualifiedReviewContent = json['Disqualified_review_content'];
    shortlistedReviewSubject = json['shortlisted_review_subject'];
    shortlistedReviewContent = json['shortlisted_review_content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    matchScore = json['score'] != null ? int.parse(json['score']) : 0;
    redirectionUrl = json['redirection_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['applied_id'] = appliedId;
    data['user_firebase_id'] = userFirebaseId;
    data['designation'] = designation;
    data['companyname'] = companyName;
    data['name'] = userName;
    data['email'] = userEmail;
    data['job_saved'] = jobStatus;
    data['jobdetails'] = jobDetails;
    data['Requirements'] = requirements;
    data['Responsilibites'] = responsibilities;
    data['emp_id'] = empId;
    data['emp_firebase'] = empFirebase;
    data['emp_name'] = empName;
    data['Topskills'] = topSkills;
    data['salaries'] = salaries;
    data['c_address'] = cAddress;
    data['c_lat'] = cLat;
    data['c_log'] = cLog;
    data['Area_Distance'] = areaDistance;
    data['jobs_Type'] = jobsType;
    data['Experience_level'] = experienceLevel;
    data['upload_photo'] = uploadPhoto;
    data['upload_resume'] = uploadResume;
    data['status'] = candidateStatus;
    // data['upload_photo'] = userProfile;
    data['Application_Received_subject'] = applicationReceivedSubject;
    data['Application_Received_content'] = applicationReceivedContent;
    data['Disqualified_review_subject'] = disqualifiedReviewSubject;
    data['Disqualified_review_content'] = disqualifiedReviewContent;
    data['shortlisted_review_subject'] = shortlistedReviewSubject;
    data['shortlisted_review_content'] = shortlistedReviewContent;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['score'] = matchScore;
    data['redirection_url'] = redirectionUrl;
    return data;
  }

  JobPosModel copyWith({
    int? id,
    int? userId,
    int? appliedId,
    String? userFirebaseId,
    int? companyId,
    String? designation,
    String? companyName,
    String? userName,
    int? jobStatus,
    int? empId,
    String? empFirebase,
    String? empName,
    String? cAddress,
    String? cLat,
    String? cLog,
    String? jobDetails,
    String? requirements,
    String? responsibilities,
    List<String>? topSkills,
    String? salaries,
    String? userEmail,
    String? areaDistance,
    String? jobsType,
    String? experienceLevel,
    String? uploadPhoto,
    String? uploadResume,
    String? candidateStatus,
    String? applicationReceivedSubject,
    String? applicationReceivedContent,
    String? disqualifiedReviewSubject,
    String? disqualifiedReviewContent,
    String? shortlistedReviewSubject,
    String? shortlistedReviewContent,
    String? createdAt,
    String? updatedAt,
    int? matchScore,
    String? jobId,
    String? redirectionUrl,
  }) {
    return JobPosModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      appliedId: appliedId ?? this.appliedId,
      userFirebaseId: userFirebaseId ?? this.userFirebaseId,
      companyId: companyId ?? this.companyId,
      designation: designation ?? this.designation,
      companyName: companyName ?? this.companyName,
      userName: userName ?? this.userName,
      jobStatus: jobStatus ?? this.jobStatus,
      empId: empId ?? this.empId,
      empFirebase: empFirebase ?? this.empFirebase,
      empName: empName ?? this.empName,
      jobDetails: jobDetails ?? this.jobDetails,
      requirements: requirements ?? this.requirements,
      responsibilities: responsibilities ?? this.responsibilities,
      topSkills: topSkills ?? this.topSkills,
      salaries: salaries ?? this.salaries,
      areaDistance: areaDistance ?? this.areaDistance,
      jobsType: jobsType ?? this.jobsType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      uploadPhoto: uploadPhoto ?? this.uploadPhoto,
      uploadResume: uploadResume ?? this.uploadResume,
      candidateStatus: candidateStatus ?? this.candidateStatus,
      applicationReceivedSubject: applicationReceivedSubject ?? this.applicationReceivedSubject,
      applicationReceivedContent: applicationReceivedContent ?? this.applicationReceivedContent,
      disqualifiedReviewSubject: disqualifiedReviewSubject ?? this.disqualifiedReviewSubject,
      disqualifiedReviewContent: disqualifiedReviewContent ?? this.disqualifiedReviewContent,
      shortlistedReviewSubject: shortlistedReviewSubject ?? this.shortlistedReviewSubject,
      shortlistedReviewContent: shortlistedReviewContent ?? this.shortlistedReviewContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      matchScore: matchScore ?? this.matchScore,
      jobId: jobId ?? this.jobId,
      redirectionUrl: redirectionUrl ?? this.redirectionUrl,
    );
  }
}

class JobDistanceModel extends Equatable {
  int? id;
  int? jobSaved;
  String? companyname;
  String? companyUploadPhoto;
  String? cAddress;
  String? cLat;
  String? cLog;
  String? designation;
  String? salaries;
  String? areaDistance;
  String? jobsType;
  String? experienceLevel;
  double? distanceFromCurrUser;

  JobDistanceModel(
      {this.id,
      this.jobSaved,
      this.companyname,
      this.companyUploadPhoto,
      this.cAddress,
      this.cLat,
      this.cLog,
      this.designation,
      this.salaries,
      this.areaDistance,
      this.jobsType,
      this.experienceLevel,
      this.distanceFromCurrUser});

  JobDistanceModel copyWith(
      {
      int? id,
      int? jobSaved,
      String? companyname,
      String? companyUploadPhoto,
      String? cAddress,
      String? cLat,
      String? cLog,
      String? designation,
      String? salaries,
      String? areaDistance,
      String? jobsType,
      String? experienceLevel,
      double? distanceFromCurrUser,
      }) {
    return JobDistanceModel(
        id: id ?? id,
        jobSaved: jobSaved ?? this.jobSaved,
        companyname: companyname ?? this.companyname,
        companyUploadPhoto: companyUploadPhoto ?? this.companyUploadPhoto,
        cAddress: cAddress ?? this.cAddress,
        cLat: cLat ?? this.cLat,
        cLog: cLog ?? this.cLog,
        designation: designation ?? this.designation,
        salaries: salaries ?? this.salaries,
        areaDistance: areaDistance ?? this.areaDistance,
        jobsType: jobsType ?? this.jobsType,
        experienceLevel: experienceLevel ?? this.experienceLevel,
        distanceFromCurrUser: distanceFromCurrUser ?? this.distanceFromCurrUser,
        );
  }

  JobDistanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobSaved = json['job_saved'];
    companyname = json['companyname'];
    companyUploadPhoto = json['company_upload_photo'];
    cAddress = json['c_address'];
    cLat = json['c_lat'];
    cLog = json['c_log'];
    designation = json['designation'];
    salaries = json['salaries'];
    areaDistance = json['Area_Distance'];
    jobsType = json['jobs_Type'];
    experienceLevel = json['Experience_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_saved'] = jobSaved;
    data['companyname'] = companyname;
    data['company_upload_photo'] = companyUploadPhoto;
    data['c_address'] = cAddress;
    data['c_lat'] = cLat;
    data['c_log'] = cLog;
    data['designation'] = designation;
    data['salaries'] = salaries;
    data['Area_Distance'] = areaDistance;
    data['jobs_Type'] = jobsType;
    data['Experience_level'] = experienceLevel;
    return data;
  }
  
  @override
  List<Object?> get props => [
    id,
    jobSaved,
    companyname,
    companyUploadPhoto,
    cAddress,
    cLat,
    cLog,
    designation,
    salaries,
    areaDistance,
    jobsType,
    experienceLevel,
  ];
}

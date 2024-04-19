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
      this.matchScore});

  JobPosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    topSkills = json['Topskills'].cast<String>() ?? [];
    salaries = json['salaries'];
    areaDistance = json['Area_Distance'];
    jobsType = json['jobs_Type'];
    experienceLevel = json['Experience_level'];
    uploadPhoto = json['upload_photo'];
    uploadResume = json['upload_resume'];
    candidateStatus = json['status'];
    // userProfile = json['upload_photo'];
    applicationReceivedSubject = json['Application_Received_subject'];
    applicationReceivedContent = json['Application_Received_content'];
    disqualifiedReviewSubject = json['Disqualified_review_subject'];
    disqualifiedReviewContent = json['Disqualified_review_content'];
    shortlistedReviewSubject = json['shortlisted_review_subject'];
    shortlistedReviewContent = json['shortlisted_review_content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    matchScore = json['match_score'] ?? 0;
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
    data['match_score'] = matchScore;
    return data;
  }
}

class JobDistanceModel {
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
      this.experienceLevel});

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
}

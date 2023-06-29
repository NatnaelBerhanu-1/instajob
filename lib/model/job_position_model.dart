class JobPosModel {
  int? id;
  int? userId;
  int? companyId;
  String? designation;
  String? companyName;
  String? userName;
  int? jobStatus;
  String? cAddress;
  String? cLat;
  String? cLog;
  String? jobDetails;
  String? requirements;
  String? responsibilities;
  List<String>? topSkills;
  String? salaries;
  String? areaDistance;
  String? jobsType;
  String? experienceLevel;
  String? uploadPhoto;
  String? uploadResume;
  String? applicationReceivedSubject;
  String? applicationReceivedContent;
  String? disqualifiedReviewSubject;
  String? disqualifiedReviewContent;
  String? shortlistedReviewSubject;
  String? shortlistedReviewContent;
  String? createdAt;
  String? updatedAt;

  JobPosModel(
      {this.id,
      this.userId,
      this.companyId,
      this.designation,
      this.jobDetails,
      this.companyName,
      this.userName,
      this.jobStatus,
      this.requirements,
      this.responsibilities,
      this.topSkills,
      this.salaries,
      this.areaDistance,
      this.jobsType,
      this.experienceLevel,
      this.uploadPhoto,
      this.uploadResume,
      this.applicationReceivedSubject,
      this.applicationReceivedContent,
      this.disqualifiedReviewSubject,
      this.disqualifiedReviewContent,
      this.shortlistedReviewSubject,
      this.shortlistedReviewContent,
      this.createdAt,
      this.updatedAt});

  JobPosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    designation = json['designation'];
    companyName = json['companyname'];
    userName = json['name'];
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
    // userProfile = json['upload_photo'];
    applicationReceivedSubject = json['Application_Received_subject'];
    applicationReceivedContent = json['Application_Received_content'];
    disqualifiedReviewSubject = json['Disqualified_review_subject'];
    disqualifiedReviewContent = json['Disqualified_review_content'];
    shortlistedReviewSubject = json['shortlisted_review_subject'];
    shortlistedReviewContent = json['shortlisted_review_content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['designation'] = designation;
    data['companyname'] = companyName;
    data['name'] = userName;
    data['job_saved'] = jobStatus;
    data['jobdetails'] = jobDetails;
    data['Requirements'] = requirements;
    data['Responsilibites'] = responsibilities;
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
    // data['upload_photo'] = userProfile;
    data['Application_Received_subject'] = applicationReceivedSubject;
    data['Application_Received_content'] = applicationReceivedContent;
    data['Disqualified_review_subject'] = disqualifiedReviewSubject;
    data['Disqualified_review_content'] = disqualifiedReviewContent;
    data['shortlisted_review_subject'] = shortlistedReviewSubject;
    data['shortlisted_review_content'] = shortlistedReviewContent;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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

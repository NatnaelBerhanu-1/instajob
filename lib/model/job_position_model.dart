class JobPosModel {
  int? id;
  int? companyId;
  String? designation;
  String? companyName;
  int? jobStatus;
  String? jobDetails;
  String? requirements;
  String? responsibilities;
  List<String>? topSkills;
  String? salaries;
  String? areaDistance;
  String? jobsType;
  String? experienceLevel;
  String? uploadPhoto;
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
      this.companyId,
      this.designation,
      this.jobDetails,
      this.companyName,
      this.jobStatus,
      this.requirements,
      this.responsibilities,
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
      this.shortlistedReviewContent,
      this.createdAt,
      this.updatedAt});

  JobPosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    designation = json['designation'];
    companyName = json['companyname'];
    jobStatus = json['job_status'];
    jobDetails = json['jobdetails'];
    requirements = json['Requirements'];
    responsibilities = json['Responsilibites'];
    topSkills = json['Topskills'].cast<String>();
    salaries = json['salaries'];
    areaDistance = json['Area_Distance'];
    jobsType = json['jobs_Type'];
    experienceLevel = json['Experience_level'];
    uploadPhoto = json['upload_photo'];
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
    data['company_id'] = companyId;
    data['designation'] = designation;
    data['companyname'] = companyName;
    data['job_status'] = jobStatus;
    data['jobdetails'] = jobDetails;
    data['Requirements'] = requirements;
    data['Responsilibites'] = responsibilities;
    data['Topskills'] = topSkills;
    data['salaries'] = salaries;
    data['Area_Distance'] = areaDistance;
    data['jobs_Type'] = jobsType;
    data['Experience_level'] = experienceLevel;
    data['upload_photo'] = uploadPhoto;
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

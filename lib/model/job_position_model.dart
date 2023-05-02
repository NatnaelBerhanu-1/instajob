class JobPosModel {
  int? id;
  String? jobdetails;
  String? designation;
  String? requirements;
  String? responsilibites;
  List<String>? topskills;
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
      this.jobdetails,
      this.designation,
      this.requirements,
      this.responsilibites,
      this.topskills,
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
    jobdetails = json['jobdetails'];
    designation = json['designation'];
    requirements = json['Requirements'];
    responsilibites = json['Responsilibites'];
    topskills = json['Topskills'].cast<String>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['jobdetails'] = jobdetails;
    data['designation'] = designation;
    data['Requirements'] = requirements;
    data['Responsilibites'] = responsilibites;
    data['Topskills'] = topskills;
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

class ResumeModel {
  int? userId;
  String? institutionName;
  String? fieldOfStudy;
  String? state;
  String? city;
  String? jobTitle;
  String? employer;
  bool? schoolHistory;
  bool? workHistory;
  String? startMonth;
  String? endMonth;
  String? startYear;
  String? endYear;
  String? updatedAt;
  String? createdAt;
  int? id;

  ResumeModel(
      {this.userId,
      this.institutionName,
      this.fieldOfStudy,
      this.state,
      this.city,
      this.jobTitle,
      this.workHistory,
      this.employer,
      this.schoolHistory,
      this.startMonth,
      this.endMonth,
      this.startYear,
      this.endYear,
      this.updatedAt,
      this.createdAt,
      this.id});

  ResumeModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    institutionName = json['institution_name'];
    fieldOfStudy = json['field_of_study'];
    state = json['state'];
    city = json['city'];
    jobTitle = json['job_title'];
    employer = json['employer'];
    schoolHistory = json['school_history'];
    workHistory = json['work_history'];
    startMonth = json['start_month'];
    endMonth = json['end_month'];
    startYear = json['start_year'];
    endYear = json['end_year'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['institution_name'] = institutionName;
    data['field_of_study'] = fieldOfStudy;
    data['state'] = state;
    data['city'] = city;
    data['job_title'] = jobTitle;
    data['employer'] = employer;
    data['school_history'] = schoolHistory;
    data['work_history'] = workHistory;
    data['start_month'] = startMonth;
    data['end_month'] = endMonth;
    data['start_year'] = startYear;
    data['end_year'] = endYear;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

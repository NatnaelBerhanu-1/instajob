class ResumeModel {
  List<TellUss>? tellUss;
  List<Skills>? skills;
  List<Achievement>? achievements;
  List<Educations>? educations;
  List<WorkExperiences>? workExperiences;

  ResumeModel(
      {this.tellUss,
      this.skills,
      this.achievements,
      this.educations,
      this.workExperiences});

  ResumeModel.fromJson(Map<String, dynamic> json) {
    if (json['tell_uss'] != null) {
      tellUss = <TellUss>[];
      json['tell_uss'].forEach((v) {
        tellUss!.add(TellUss.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(Skills.fromJson(v));
      });
    }
    if (json['achivments'] != null) {
      achievements = <Achievement>[];
      json['achivments'].forEach((v) {
        achievements!.add(Achievement.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
    if (json['work_experiences'] != null) {
      workExperiences = <WorkExperiences>[];
      json['work_experiences'].forEach((v) {
        workExperiences!.add(WorkExperiences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tellUss != null) {
      data['tell_uss'] = tellUss!.map((v) => v.toJson()).toList();
    }
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    if (achievements != null) {
      data['achivments'] = achievements!.map((v) => v.toJson()).toList();
    }
    if (educations != null) {
      data['educations'] = educations!.map((v) => v.toJson()).toList();
    }
    if (workExperiences != null) {
      data['work_experiences'] =
          workExperiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TellUss {
  int? userId;
  String? tellUs;

  TellUss({this.userId, this.tellUs});

  TellUss.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    tellUs = json['tell_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['tell_us'] = tellUs;
    return data;
  }
}

class Skills {
  List<String>? addSkill;

  Skills({this.addSkill});

  Skills.fromJson(Map<String, dynamic> json) {
    addSkill = json['add_skill'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add_skill'] = addSkill;
    return data;
  }
}

class Achievement {
  List<String>? achievements;

  Achievement({this.achievements});

  Achievement.fromJson(Map<String, dynamic> json) {
    achievements = json['achivments_skill'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['achivments_skill'] = achievements;
    return data;
  }
}

class Educations {
  int? id;
  String? institutionName;
  String? fieldOfStudy;
  String? educationState;
  String? educationCity;
  int? schoolHistory;
  String? educationStartMonth;
  String? educationEndMonth;
  String? educationStartYear;
  String? educationEndYear;
  String? educationCustomMessage;

  Educations(
      {this.id,
      this.institutionName,
      this.fieldOfStudy,
      this.educationState,
      this.educationCity,
      this.schoolHistory,
      this.educationStartMonth,
      this.educationEndMonth,
      this.educationStartYear,
      this.educationEndYear,
      this.educationCustomMessage});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    institutionName = json['institution_name'];
    fieldOfStudy = json['field_of_study'];
    educationState = json['education_state'];
    educationCity = json['education_city'];
    schoolHistory = json['school_history'];
    educationStartMonth = json['education_start_month'];
    educationEndMonth = json['education_end_month'];
    educationStartYear = json['education_start_year'];
    educationEndYear = json['education_end_year'];
    educationCustomMessage = json['education_custom_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institution_name'] = institutionName;
    data['field_of_study'] = fieldOfStudy;
    data['education_state'] = educationState;
    data['education_city'] = educationCity;
    data['school_history'] = schoolHistory;
    data['education_start_month'] = educationStartMonth;
    data['education_end_month'] = educationEndMonth;
    data['education_start_year'] = educationStartYear;
    data['education_end_year'] = educationEndYear;
    data['education_custom_message'] = educationCustomMessage;
    return data;
  }
}

class WorkExperiences {
  int? id;
  String? jobTitle;
  String? employer;
  String? workState;
  String? workCity;
  int? workHistory;
  String? workStartMonth;
  String? workEndMonth;
  String? workStartYear;
  String? workEndYear;
  String? workCustomMessage;

  WorkExperiences(
      {this.id,
      this.jobTitle,
      this.employer,
      this.workState,
      this.workCity,
      this.workHistory,
      this.workStartMonth,
      this.workEndMonth,
      this.workStartYear,
      this.workEndYear,
      this.workCustomMessage});

  WorkExperiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['job_title'];
    employer = json['employer'];
    workState = json['work_state'];
    workCity = json['work_city'];
    workHistory = json['work_history'];
    workStartMonth = json['work_start_month'];
    workEndMonth = json['work_end_month'];
    workStartYear = json['work_start_year'];
    workEndYear = json['work_end_year'];
    workCustomMessage = json['work_custom_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_title'] = jobTitle;
    data['employer'] = employer;
    data['work_state'] = workState;
    data['work_city'] = workCity;
    data['work_history'] = workHistory;
    data['work_start_month'] = workStartMonth;
    data['work_end_month'] = workEndMonth;
    data['work_start_year'] = workStartYear;
    data['work_end_year'] = workEndYear;
    data['work_custom_message'] = workCustomMessage;
    return data;
  }
}

class FilterModel {
  String? searchJobs;
  String? startSalary;
  String? endSalary;
  String? areaDistance;
  String? jobsType;
  String? experienceLevel;
  String? last24;
  String? last3;
  String? last7;
  String? last14;
  String? sortbydate;

  FilterModel(
      {this.searchJobs,
      this.startSalary,
      this.endSalary,
      this.areaDistance,
      this.jobsType,
      this.experienceLevel,
      this.last24,
      this.last3,
      this.last7,
      this.last14,
      this.sortbydate});

  FilterModel.fromJson(Map<String, dynamic> json) {
    searchJobs = json['search_jobs'];
    startSalary = json['start_salary'];
    endSalary = json['end_salary'];
    areaDistance = json['area_distance'];
    jobsType = json['jobs_Type'];
    experienceLevel = json['Experience_level'];
    last24 = json['last_24'];
    last3 = json['last_3'];
    last7 = json['last_7'];
    last14 = json['last_14'];
    sortbydate = json['sortbydate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_jobs'] = searchJobs;
    data['start_salary'] = startSalary;
    data['end_salary'] = endSalary;
    data['area_distance'] = areaDistance;
    data['jobs_Type'] = jobsType;
    data['Experience_level'] = experienceLevel;
    data['last_24'] = last24;
    data['last_3'] = last3;
    data['last_7'] = last7;
    data['last_14'] = last14;
    data['sortbydate'] = sortbydate;
    return data;
  }
}

class FilterModel {
  String? searchJobs;
  String? filter;
  String? startSalary;
  String? endSalary;
  String? areaDistance;
  String? parttime;
  String? contract;
  String? temporary;
  String? entrylevel;
  String? midlevel;
  String? seniorlevel;
  String? experienceLevel;
  String? last24;
  String? last3;
  String? last7;
  String? last14;

  FilterModel(
      {this.searchJobs,
      this.filter,
      this.startSalary,
      this.endSalary,
      this.areaDistance,
      this.parttime,
      this.contract,
      this.temporary,
      this.entrylevel,
      this.midlevel,
      this.seniorlevel,
      this.experienceLevel,
      this.last24,
      this.last3,
      this.last7,
      this.last14});

  FilterModel.fromJson(Map<String, dynamic> json) {
    searchJobs = json['search_jobs'];
    filter = json['filter'];
    startSalary = json['start_salary'];
    endSalary = json['end_salary'];
    areaDistance = json['area_distance'];
    parttime = json['parttime'];
    contract = json['contract'];
    temporary = json['temporary'];
    entrylevel = json['entrylevel'];
    midlevel = json['midlevel'];
    seniorlevel = json['seniorlevel'];
    experienceLevel = json['experience_level'];
    last24 = json['last_24'];
    last3 = json['last_3'];
    last7 = json['last_7'];
    last14 = json['last_14'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_jobs'] = searchJobs;
    data['filter'] = filter;
    data['start_salary'] = startSalary;
    data['end_salary'] = endSalary;
    data['area_distance'] = areaDistance;
    data['parttime'] = parttime;
    data['contract'] = contract;
    data['temporary'] = temporary;
    data['entrylevel'] = entrylevel;
    data['midlevel'] = midlevel;
    data['seniorlevel'] = seniorlevel;
    data['experience_level'] = experienceLevel;
    data['last_24'] = last24;
    data['last_3'] = last3;
    data['last_7'] = last7;
    data['last_14'] = last14;
    return data;
  }
}

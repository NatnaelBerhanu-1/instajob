class AppliedJobModel {
  int? id;
  String? name;
  String? email;
  int? companyId;
  String? designation;
  String? jobdetails;
  String? uploadResume;
  String? status;

  AppliedJobModel(
      {this.id,
      this.name,
      this.email,
      this.companyId,
      this.designation,
      this.jobdetails,
      this.uploadResume,
      this.status});

  AppliedJobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    companyId = json['company_id'];
    designation = json['designation'];
    jobdetails = json['jobdetails'];
    uploadResume = json['upload_resume'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['company_id'] = companyId;
    data['designation'] = designation;
    data['jobdetails'] = jobdetails;
    data['upload_resume'] = uploadResume;
    data['status'] = status;
    return data;
  }
}

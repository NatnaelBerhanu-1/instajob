class CompanyModel {
  int? id;
  int? employeeId;
  String? employeeName;
  String? companyName;
  String? uploadPhoto;
  String? createdAt;
  String? updatedAt;

  CompanyModel(
      {this.id,
      this.employeeId,
      this.employeeName,
      this.companyName,
      this.uploadPhoto,
      this.createdAt,
      this.updatedAt});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employe_id'];
    employeeName = json['employe_name'];
    companyName = json['companyname'];
    uploadPhoto = json['upload_photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employe_id'] = employeeId;
    data['employe_name'] = employeeName;
    data['companyname'] = companyName;
    data['upload_photo'] = uploadPhoto;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

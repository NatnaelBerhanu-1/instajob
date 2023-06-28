class CompanyModel {
  int? employeeId;
  String? companyName;
  String? uploadPhoto;
  String? cAddress;
  String? cLat;
  String? cLog;
  String? updatedAt;
  String? createdAt;
  int? id;

  CompanyModel(
      {this.employeeId,
      this.companyName,
      this.uploadPhoto,
      this.cAddress,
      this.cLat,
      this.cLog,
      this.updatedAt,
      this.createdAt,
      this.id});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employe_id'];
    companyName = json['companyname'];
    uploadPhoto = json['upload_photo'];
    cAddress = json['c_address'];
    cLat = json['c_lat'];
    cLog = json['c_log'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employe_id'] = employeeId;
    data['companyname'] = companyName;
    data['upload_photo'] = uploadPhoto;
    data['c_address'] = cAddress;
    data['c_lat'] = cLat;
    data['c_log'] = cLog;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

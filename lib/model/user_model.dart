class UserModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? uploadPhoto;
  String? companyName;
  String? websiteLink;
  String? type;
  String? date;
  String? cv;
  String? fcmToken;
  String? firebaseId;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserModel(
      {this.name,
      this.email,
      this.phoneNumber,
      this.uploadPhoto,
      this.companyName,
      this.websiteLink,
      this.type,
      this.date,
      this.cv,
      this.fcmToken,
      this.firebaseId,
      this.updatedAt,
      this.createdAt,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    uploadPhoto = json['upload_photo'];
    companyName = json['company_name'];
    websiteLink = json['website_link'];
    type = json['type'];
    date = json['date'];
    cv = json['cv'];
    fcmToken = json['fcm_token'];
    firebaseId = json['firebase_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['upload_photo'] = uploadPhoto;
    data['company_name'] = companyName;
    data['website_link'] = websiteLink;
    data['type'] = type;
    data['date'] = date;
    data['cv'] = cv;
    data['fcm_token'] = fcmToken;
    data['firebase_id'] = firebaseId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

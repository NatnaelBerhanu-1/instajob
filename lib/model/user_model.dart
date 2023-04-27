class UserModel {
  int? id;
  String? name;
  String? email;
  String? date;
  String? phoneNumber;
  String? type;
  String? uploadPhoto;
  String? fcmToken;
  String? firebaseId;
  String? updatedAt;
  String? createdAt;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.date,
      this.type,
      this.uploadPhoto,
      this.fcmToken,
      this.phoneNumber,
      this.firebaseId,
      this.updatedAt,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    date = json['date'];
    phoneNumber = json['phone_number'];
    type = json['type'];
    uploadPhoto = json['upload_photo'];
    fcmToken = json['fcm_token'];
    firebaseId = json['firebase_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['date'] = date;
    data['phone_number'] = phoneNumber;
    data['type'] = type;
    data['upload_photo'] = uploadPhoto;
    data['fcm_token'] = fcmToken;
    data['firebase_id'] = firebaseId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

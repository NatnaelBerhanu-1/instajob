class UserModel {
  int? id;
  String? name;
  String? email;
  String? type;
  String? fcmToken;
  String? firebaseId;
  String? updatedAt;
  String? createdAt;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.fcmToken,
      this.firebaseId,
      this.updatedAt,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
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
    data['type'] = type;
    data['fcm_token'] = fcmToken;
    data['firebase_id'] = firebaseId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

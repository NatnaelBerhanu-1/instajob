class UserModel {
  int? id;
  String? firebaseId;
  String? fcmToken;
  String? name;
  String? email;
  int? emailCode;
  String? companyName;
  String? phoneNumber;
  String? type;
  String? applicationReceivedSubject;
  String? applicationReceivedContent;
  String? disqualifiedReviewSubject;
  String? disqualifiedReviewContent;
  String? shortlistedReviewSubject;
  String? shortlistedReviewContent;
  int? automateMsgBtn;
  String? websiteLink;
  String? cv;
  String? date;
  String? uploadPhoto;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? deletedAt;

  UserModel(
      {this.id,
      this.firebaseId,
      this.fcmToken,
      this.name,
      this.email,
      this.emailCode,
      this.companyName,
      this.phoneNumber,
      this.type,
      this.date,
      this.cv,
      this.applicationReceivedSubject,
      this.applicationReceivedContent,
      this.disqualifiedReviewSubject,
      this.disqualifiedReviewContent,
      this.shortlistedReviewSubject,
      this.shortlistedReviewContent,
      this.automateMsgBtn,
      this.websiteLink,
      this.uploadPhoto,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    fcmToken = json['fcm_token'];
    name = json['name'];
    email = json['email'];
    emailCode = json['email_code'];
    companyName = json['company_name'];
    phoneNumber = json['phone_number'];
    type = json['type'];
    applicationReceivedSubject = json['Application_Received_subject'];
    applicationReceivedContent = json['Application_Received_content'];
    disqualifiedReviewSubject = json['Disqualified_review_subject'];
    disqualifiedReviewContent = json['Disqualified_review_content'];
    shortlistedReviewSubject = json['shortlisted_review_subject'];
    shortlistedReviewContent = json['shortlisted_review_content'];
    automateMsgBtn = json['automate_msg_btn'];
    websiteLink = json['website_link'];
    uploadPhoto = json['upload_photo'];
    date = json['date'];
    cv = json['cv'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['email_code'] = emailCode;
    data['company_name'] = companyName;
    data['phone_number'] = phoneNumber;
    data['type'] = type;
    data['date'] = date;
    data['cv'] = cv;
    data['Application_Received_subject'] = applicationReceivedSubject;
    data['Application_Received_content'] = applicationReceivedContent;
    data['Disqualified_review_subject'] = disqualifiedReviewSubject;
    data['Disqualified_review_content'] = disqualifiedReviewContent;
    data['shortlisted_review_subject'] = shortlistedReviewSubject;
    data['shortlisted_review_content'] = shortlistedReviewContent;
    data['automate_msg_btn'] = automateMsgBtn;
    data['website_link'] = websiteLink;
    data['upload_photo'] = uploadPhoto;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

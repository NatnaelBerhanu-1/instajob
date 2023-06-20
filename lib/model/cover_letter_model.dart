class CoverLetterModel {
  int? id;
  int? userId;
  String? yourName;
  int? phoneNumber;
  String? yourTop5Skills;
  String? previousWork;
  String? yourPassion;
  String? uploadResume;

  CoverLetterModel(
      {this.id,
      this.userId,
      this.yourName,
      this.phoneNumber,
      this.yourTop5Skills,
      this.previousWork,
      this.yourPassion,
      this.uploadResume});

  CoverLetterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    yourName = json['your_name'];
    phoneNumber = json['phone_number'];
    yourTop5Skills = json['your_top_5_skills'];
    previousWork = json['previous_work'];
    yourPassion = json['your_passion'];
    uploadResume = json['upload_resume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['your_name'] = yourName;
    data['phone_number'] = phoneNumber;
    data['your_top_5_skills'] = yourTop5Skills;
    data['previous_work'] = previousWork;
    data['your_passion'] = yourPassion;
    data['upload_resume'] = uploadResume;
    return data;
  }
}

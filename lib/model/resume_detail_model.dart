import 'dart:convert';

ResumeDetailModel resumeDetailsFromJson(String str) => ResumeDetailModel.fromJson(json.decode(str));

String resumeDetailsToJson(ResumeDetailModel data) => json.encode(data.toJson());

class ResumeDetailModel {
  final String? address;
  final List<EducationDetail>? educationDetail;
  final String? email;
  final String? phone;
  final List<Experience>? experience;
  final String? name;
  final List<String>? skills;

  ResumeDetailModel({
    required this.address,
    required this.educationDetail,
    required this.email,
    required this.phone,
    required this.experience,
    required this.name,
    required this.skills,
  });

  ResumeDetailModel copyWith({
    String? address,
    List<EducationDetail>? educationDetail,
    String? email,
    String? phone,
    List<Experience>? experience,
    String? name,
    List<String>? skills,
  }) =>
      ResumeDetailModel(
        address: address ?? this.address,
        educationDetail: educationDetail ?? this.educationDetail,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        experience: experience ?? this.experience,
        name: name ?? this.name,
        skills: skills ?? this.skills,
      );

  factory ResumeDetailModel.fromJson(Map<String, dynamic> json) => ResumeDetailModel(
        address: json["address"],
        educationDetail: json["education"] == null
            ? null
            : List<EducationDetail>.from(json["education"].map((x) => EducationDetail.fromJson(x))),
        email: json["email"],
        phone: json["phone"],
        experience: json["experience"] == null
            ? null
            : List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))),
        name: json["name"],
        skills: json["skills"] == null ? null : List<String>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        if (educationDetail != null) "educationDetail": List<dynamic>.from(educationDetail!.map((x) => x.toJson())),
        "email": email,
        "phone": phone,
        if (experience != null) "experience": List<dynamic>.from(experience!.map((x) => x.toJson())),
        "name": name,
        if (skills != null) "skills": List<dynamic>.from(skills!.map((x) => x)),
      };
}

class EducationDetail {
  final String name;

  EducationDetail({
    required this.name,
  });

  EducationDetail copyWith({
    List<String>? dates,
    String? name,
  }) =>
      EducationDetail(
        name: name ?? this.name,
      );

  factory EducationDetail.fromJson(Map<String, dynamic> json) => EducationDetail(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Experience {
  final String location;
  final String organization;
  final String title;

  Experience({
    required this.location,
    required this.organization,
    required this.title,
  });

  Experience copyWith({
    String? location,
    String? organization,
    String? title,
  }) =>
      Experience(
        location: location ?? this.location,
        organization: organization ?? this.organization,
        title: title ?? this.title,
      );

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        location: json["location"] ?? "",
        organization: json["organization"] ?? "",
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "organization": organization,
        "title": title,
      };
}

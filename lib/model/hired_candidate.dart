
import 'package:equatable/equatable.dart';
import 'package:insta_job/model/payment_user.dart';
import 'dart:convert';

HiredCandidate hiredCandidateFromJson(String str) =>
    HiredCandidate.fromJson(json.decode(str));

String hiredCandidateToJson(HiredCandidate data) => json.encode(data.toJson());

class HiredCandidate extends Equatable {
  final int id;
  final int userId;
  final int jobId;
  final String uploadResume;
  final String status;
  final PaymentUser user;

  const HiredCandidate({
    required this.id,
    required this.userId,
    required this.jobId,
    required this.uploadResume,
    required this.status,
    required this.user,
  });

  HiredCandidate copyWith({
    int? id,
    int? userId,
    int? jobId,
    String? uploadResume,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    PaymentUser? user,
  }) =>
      HiredCandidate(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        jobId: jobId ?? this.jobId,
        uploadResume: uploadResume ?? this.uploadResume,
        status: status ?? this.status,
        user: user ?? this.user,
      );

  factory HiredCandidate.fromJson(Map<String, dynamic> json) {
    return HiredCandidate(
        id: json["id"],
        userId: json["user_id"],
        jobId: json["job_id"],
        uploadResume: json["upload_resume"],
        status: json["status"],
        user: PaymentUser.fromJson(json["user"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "job_id": jobId,
        "upload_resume": uploadResume,
        "status": status,
        "user": user.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        jobId,
        uploadResume,
        status,
        user,
      ];
}


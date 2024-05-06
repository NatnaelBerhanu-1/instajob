import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel extends Equatable {
  final String? oppId;
  final String? selfId;
  final String gp;
  final String? msg;
  final String? userName;
  final String? profile;
  final String? jobId;
  final String? oppName;
  final String? selfName;
  final String? selfProfilePic;
  final String? oppProfilePic;
  final int? selfUnreadCount;
  final int? oppUnreadCount;
  final String? oppTitle;
  final String? companyId;
  final String? userId;
  ChatModel(
      {this.oppId,
      this.selfId,
      required this.gp,
      this.msg,
      this.userName,
      this.profile,
      this.jobId,
      this.oppName,
      this.selfName,
      this.selfProfilePic,
      this.oppProfilePic,
      this.selfUnreadCount,
      this.oppUnreadCount,
      this.oppTitle,
      this.companyId,
      this.userId});

  Map<String, dynamic> getMessageData() {
    return <String, dynamic>{
      'oppId': oppId,
      'selfId': selfId,
      // 'selfUnreadCount': selfUnreadCount,
      // 'oppUnreadCount': oppUnreadCount,
      'msg': msg,
      'userName': userName,
      'profile': profile,
      'jobId': jobId,
      'group': gp,
      'time': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> getChatData() {
    return <String, dynamic>{
      'gp': gp,
      'oppId': oppId,
      'selfId': selfId,
      'selfUnreadCount': selfUnreadCount,
      'oppUnreadCount': oppUnreadCount,
      'jobId': jobId,
      'oppName': oppName,
      'selfName': selfName,
      'oppProfilePic': oppProfilePic,
      'selfProfilePic': selfProfilePic,
      'oppTitle': oppTitle,
      'companyId': companyId,
      'userId': userId
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      oppId: map['oppId'] != null ? map['oppId'] as String : null,
      selfId: map['selfId'] != null ? map['selfId'] as String : null,
      gp: map['gp'] as String,
      msg: map['msg'] != null ? map['msg'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      profile: map['profile'] != null ? map['profile'] as String : null,
      jobId: map['jobId'] != null ? map['jobId'] as String : null,
      oppName: map['oppName'] != null ? map['oppName'] as String : null,
      selfName: map['selfName'] != null ? map['selfName'] as String : null,
      selfProfilePic: map['selfProfilePic'] != null ? map['selfProfilePic'] as String : null,
      oppProfilePic: map['oppProfilePic'] != null ? map['oppProfilePic'] as String : null,
      selfUnreadCount: map['selfUnreadCount'] != null ? map['selfUnreadCount'] as int : null,
      oppUnreadCount: map['oppUnreadCount'] != null ? map['oppUnreadCount'] as int : null,
      oppTitle: map['oppTitle'] != null ? map['oppTitle'] as String : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,

    );
  }

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ChatModel copyWith(
      {String? oppId,
      String? selfId,
      String? gp,
      String? msg,
      String? userName,
      String? profile,
      String? jobId,
      String? oppName,
      String? selfName,
      String? selfProfilePic,
      String? oppProfilePic,
      int? selfUnreadCount,
      int? oppUnreadCount,
      String? oppTitle,
      String? companyId,
      String? userId}) {
    return ChatModel(
        oppId: oppId ?? this.oppId,
        selfId: selfId ?? this.selfId,
        gp: gp ?? this.gp,
        msg: msg ?? this.msg,
        userName: userName ?? this.userName,
        profile: profile ?? this.profile,
        jobId: jobId ?? this.jobId,
        oppName: oppName ?? this.oppName,
        selfName: selfName ?? this.selfName,
        selfProfilePic: selfProfilePic ?? this.selfProfilePic,
        oppProfilePic: oppProfilePic ?? this.oppProfilePic,
        selfUnreadCount: selfUnreadCount ?? this.selfUnreadCount,
        oppUnreadCount: oppUnreadCount ?? this.oppUnreadCount,
        oppTitle: oppTitle ?? this.oppTitle,
        companyId: companyId ?? this.userId,
        userId: userId ?? this.userId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oppId': oppId,
      'selfId': selfId,
      'gp': gp,
      'msg': msg,
      'userName': userName,
      'profile': profile,
      'jobId': jobId,
      'oppName': oppName,
      'selfName': selfName,
      'selfProfilePic': selfProfilePic,
      'oppProfilePic': oppProfilePic,
      'selfUnreadCount': selfUnreadCount,
      'oppUnreadCount': oppUnreadCount,
      'oppTitle': oppTitle,
      'companyId': companyId
    };
  }

  String toJson() => json.encode(toMap());
  
  @override
  List<Object?> get props => [
    oppId,
    selfId,
    gp,
    msg,
    userName,
    profile,
    jobId,
    oppName,
    selfName,
    selfProfilePic,
    oppProfilePic,
    selfUnreadCount,
    oppUnreadCount,
    oppTitle,
    companyId,
    userId,
  ];
}

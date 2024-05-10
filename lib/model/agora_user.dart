
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AgoraUser extends Equatable {
  final int uid;
  String? name;
  bool? isAudioEnabled;
  bool? isVideoEnabled;
  Widget? view;

  AgoraUser({
    required this.uid,
    this.name,
    this.isAudioEnabled,
    this.isVideoEnabled,
    this.view,
  });
  
  @override
  List<Object?> get props => [uid, name, isAudioEnabled, isVideoEnabled];
}

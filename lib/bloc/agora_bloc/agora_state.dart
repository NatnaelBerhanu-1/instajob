import 'package:equatable/equatable.dart';

class AgoraInitial extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnJoinChannelSuccess extends AgoraInitial {}

class OnUserJoined extends AgoraInitial {}

class OnUserOffline extends AgoraInitial {}

class OnError extends AgoraInitial {}

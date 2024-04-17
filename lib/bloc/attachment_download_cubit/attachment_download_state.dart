import 'package:equatable/equatable.dart';

abstract class AttachmentDownloadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttachmentDownloadInitial extends AttachmentDownloadState {}

class AttachmentDownloadLoading extends AttachmentDownloadState {}

class AttachmentDownloadSuccess extends AttachmentDownloadState {
  final List<String>? downloadedFilesUrlPaths;

  AttachmentDownloadSuccess({
    required this.downloadedFilesUrlPaths,
  });
  @override
  List<Object?> get props => [downloadedFilesUrlPaths];
}

class AttachmentDownloadErrorState extends AttachmentDownloadState {
  final String message;

  AttachmentDownloadErrorState({
    required this.message,
  });
}

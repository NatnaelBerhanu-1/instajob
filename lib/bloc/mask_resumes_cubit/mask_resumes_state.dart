import 'package:equatable/equatable.dart';

abstract class MaskResumesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MaskResumesInitial extends MaskResumesState {}

class MaskResumesLoading extends MaskResumesState {}

class MaskResumesSuccess extends MaskResumesState {
  final List<String>? downloadedMaskedFilesUrlPaths;
  final bool resumesAreMasked;

  MaskResumesSuccess({
    required this.downloadedMaskedFilesUrlPaths,
    required this.resumesAreMasked,
  });
  @override
  List<Object?> get props => [downloadedMaskedFilesUrlPaths];
}

class MaskResumesErrorState extends MaskResumesState {
  final String message;

  MaskResumesErrorState({
    required this.message,
  });
}

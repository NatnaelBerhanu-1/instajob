import 'package:equatable/equatable.dart';

abstract class UploadKycState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadKycInitial extends UploadKycState {}

class UploadKycLoading extends UploadKycState {
  UploadKycLoading();

}

class UploadKycSuccess extends UploadKycState {}

class UploadKycErrorState extends UploadKycState {
  final String message;

  UploadKycErrorState({
    required this.message,
  });
}

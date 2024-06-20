import 'package:equatable/equatable.dart';

abstract class AddBankingInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddBankingInfoInitial extends AddBankingInfoState {}

class AddBankingInfoLoading extends AddBankingInfoState {
  AddBankingInfoLoading();
}

class AddBankingInfoSuccess extends AddBankingInfoState {}

class AddBankingInfoErrorState extends AddBankingInfoState {
  final String message;

  AddBankingInfoErrorState({
    required this.message,
  });
}

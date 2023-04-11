import 'package:equatable/equatable.dart';
import 'package:insta_job/model/company_model.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();
  @override
  List<Object?> get props => [];
}

class Initial extends CompanyState {}

class EmptyData extends CompanyState {
  final String message;

  const EmptyData(this.message);
  @override
  List<Object?> get props => [message];
}

class CompanyLoading extends CompanyState {
  @override
  List<Object?> get props => [];
}

class CompanyLoaded extends CompanyState {
  final List<CompanyModel> companyList;
  const CompanyLoaded(this.companyList);

  @override
  List<Object?> get props => [companyList];
}

class ErrorState extends CompanyState {
  final String error;

  const ErrorState(this.error);
  @override
  List<Object?> get props => [];
}

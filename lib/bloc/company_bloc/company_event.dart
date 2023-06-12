import 'package:equatable/equatable.dart';
import 'package:insta_job/model/filter_model.dart';

abstract class CompanyEvent extends Equatable {}

class LoadCompanyListEvent extends CompanyEvent {
  @override
  List<Object?> get props => [];
}

class AddCompanyEvent extends CompanyEvent {
  final String companyName;
  final String photo;

  AddCompanyEvent({required this.companyName, required this.photo});
  @override
  List<Object?> get props => [companyName, photo];
}

class CompanySearchEvent extends CompanyEvent {
  final String search;

  CompanySearchEvent({required this.search});
  @override
  List<Object?> get props => [];
}

class JobSearchEvent extends CompanyEvent {
  final FilterModel filterModel;

  JobSearchEvent({required this.filterModel});
  @override
  List<Object?> get props => [];
}

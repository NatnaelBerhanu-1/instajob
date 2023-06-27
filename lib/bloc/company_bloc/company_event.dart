import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {}

class LoadCompanyListEvent extends CompanyEvent {
  @override
  List<Object?> get props => [];
}

class AddCompanyEvent extends CompanyEvent {
  final String companyName;
  final String photo;
  final String? address;
  final String? lat;
  final String? lang;
  AddCompanyEvent(
      {this.address,
      this.lat,
      this.lang,
      required this.companyName,
      required this.photo});
  @override
  List<Object?> get props => [companyName, photo];
}

class CompanySearchEvent extends CompanyEvent {
  final String search;

  CompanySearchEvent({required this.search});
  @override
  List<Object?> get props => [];
}

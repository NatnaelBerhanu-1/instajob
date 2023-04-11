import 'package:equatable/equatable.dart';

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

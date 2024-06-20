import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/banking_info_bloc/add_banking_info/add_banking_info_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/banking_info_repository.dart';

class AddBankingInfoCubit extends Cubit<AddBankingInfoState> {
  final BankingInfoRepo repo;
  AddBankingInfoCubit(this.repo) : super(AddBankingInfoInitial());

  Future<void> addBankingInfo({
    required String accountNumber,
    required String selectedAccountType,
    required String bankRoutingNumber,
    required String country,
    required String ownerFullName,
  }) async {
    debugPrint(
        "acc $accountNumber type $selectedAccountType routing $bankRoutingNumber country $country name $ownerFullName");
    emit(AddBankingInfoLoading());
    try {
      ApiResponse response = await repo.addBankingInformation(
        accountNumber: accountNumber,
        selectedAccountType: selectedAccountType,
        bankRoutingNumber: bankRoutingNumber,
        country: country,
        ownerFullName: ownerFullName,
      );

      if (response.appStatusCode == AppStatusCode.serverError) {
        emit(AddBankingInfoErrorState(
            message: "Server error. Something went wrong. Please try again."));
      } else if (response.appStatusCode == AppStatusCode.success) {
        emit(AddBankingInfoSuccess());
      } else {
        emit(AddBankingInfoErrorState(message: "Data not found"));
      }
    } catch (e) {
      emit(AddBankingInfoErrorState(message: "Banking info error"));
    }
  }
}

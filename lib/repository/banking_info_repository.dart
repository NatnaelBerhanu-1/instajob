import 'package:flutter/material.dart';
import 'package:insta_job/network/dio/dio_client.dart';

import '../network/api_response.dart';

class BankingInfoRepo {
  final DioClient dioClient;

  BankingInfoRepo({required this.dioClient});

  Future<ApiResponse> addBankingInformation({
    required String accountNumber,
    required String selectedAccountType,
    required String bankRoutingNumber,
    required String country,
    required String ownerFullName,
  }) async {
    try {
      var map = {
        "account_number": accountNumber,
        "selected_account_type": selectedAccountType,
        "bank_routing_number": bankRoutingNumber,
        "country": country,
        "full_name": ownerFullName,
      };
      debugPrint("map payload[add bank info] $map");
      throw Exception(); //TODO: REVISIT once BE is tested
      // var response =
      //     await dioClient.post(uri: EndPoint.addBankingInfo, data: map);
      // debugPrint("map payload[add bank info] success");
      // return ApiResponse.withSuccess(response);
    } catch (e) {
      debugPrint("map payload[add bank info] error");
      return ApiResponse.withError(e);
    }
  }
}

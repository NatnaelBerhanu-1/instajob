import 'dart:io';

class ApiResponse {
  final dynamic response;

  ApiResponse.withError(dynamic responseValue) : response = responseValue;

  ApiResponse.withSuccess(dynamic responseValue) : response = responseValue;

  ApiResponse.noInternet() : response = const SocketException('');

}

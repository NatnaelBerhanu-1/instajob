import 'dart:io';

class ApiResponse {
  final dynamic response;
  AppStatusCode? appStatusCode;

  ApiResponse.withError(dynamic responseValue)
      : response = responseValue,
        appStatusCode = AppStatusCode.error;

  ApiResponse.withSuccess(dynamic responseValue, [AppStatusCode? statusCode])
      : response = responseValue,
        appStatusCode = AppStatusCode.success;

  ApiResponse.noInternet() : response = const SocketException('');
}

/// Custom status code for the app.
enum AppStatusCode {
  success,
  error,
  serverError,
  //todo: add more
}

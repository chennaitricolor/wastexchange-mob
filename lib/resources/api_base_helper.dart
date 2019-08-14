//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wastexchange_mobile/util/http_interceptors/auth_interceptor.dart';
import 'package:wastexchange_mobile/util/http_interceptors/log_interceptor.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';

class ApiBaseHelper {

  ApiBaseHelper._internal(HttpClientWithInterceptor interceptor) {
    _httpClient = interceptor;
  }

  static final ApiBaseHelper _instance = ApiBaseHelper._internal(HttpClientWithInterceptor.build(interceptors: [LogInterceptor()]));

  static final ApiBaseHelper _instanceWithAuth = ApiBaseHelper._internal(HttpClientWithInterceptor.build(interceptors: [AuthInterceptor(TokenRepository()), LogInterceptor()]));

  static ApiBaseHelper getInstance() {
    return _instance;
  }

  static ApiBaseHelper getInstanceWithAuth() {
    return _instanceWithAuth;
  }

  static String baseApiUrl = DotEnv().env['BASE_API_URL'];

  HttpClientWithInterceptor _httpClient;

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await _httpClient.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    dynamic responseJson;
    try {

      final response = await _httpClient.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    final String responseStr = response.body.toString();
    debugPrint(responseStr);
    if (isSuccessfulResponse(response.statusCode)) {
      debugPrint('Success Response');
      return responseStr;
    }
    debugPrint('Failure Response');
    handleUnsuccessfulStatusCode(response, responseStr);
  }

  static bool isSuccessfulResponse(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  void handleUnsuccessfulStatusCode(Response response, String responseStr) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(responseStr);
      case 401:
      case 403:
        throw UnauthorisedException(responseStr);
      case 404:
        throw ResourceNotFoundException(responseStr);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server with statusCode : ${response.statusCode}');
    }
  }
}


//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/resources/auth_manager.dart';

class ApiBaseHelper {
  ApiBaseHelper([HttpWithInterceptor http]) {
    _http = http ?? HttpWithInterceptor.build(interceptors: [AuthInterceptor(), LogInterceptor()]);
  }

  static const String BASE_API_URL = 'https://data.indiawasteexchange.com';
  HttpWithInterceptor _http;

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await _http.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await _http.post(url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    final String responseStr = response.body.toString();
    print(responseStr);
    if(isSuccessfulResponse(response.statusCode)) {
      return json.decode(responseStr);
    }

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

/*
Interceptor that modify API Request by adding authentication information to the request.
 */
class AuthInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    await addAuthHeader(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }

  Future<void> addAuthHeader(RequestData data) async {
    final String token = await AuthManager().getAccessToken();
    if(token != null) {
      data.headers['Authorization'] = token;
    }
  }
}

///
/// Interceptor for debug purpose.
///
class LogInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    printRequestLog(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    printResponseLog(data);
    return data;
  }

  void printRequestLog(RequestData data) {
    print('Method: ${data.method}');
    print('Url: ${data.url}');
    print('Body: ${data.body}');
  }

  void printResponseLog(ResponseData data) {
    print('Status Code: ${data.statusCode}');
    print('Method: ${data.method}');
    print('Url: ${data.url}');
    print('Body: ${data.body}');
    print('Headers: ${data.headers}');
  }
}
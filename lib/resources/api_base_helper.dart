//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wastexchange_mobile/util/logger.dart';

class ApiBaseHelper {
  ApiBaseHelper([Client client]) {
    _client = client ?? Client();
  }

  final logger = getLogger('ApiBaseHelper');
  static final String _baseApiUrl = DotEnv().env['BASE_API_URL'];
  Client _client;

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await _client.get(_baseApiUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await _client.post(_baseApiUrl + url,
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
    logger.i(responseStr);
    if (isSuccessfulResponse(response.statusCode)) {
      logger.i('Success Response');
      return responseStr;
    }
    logger.i('Failure Response');
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

//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';

class ApiBaseHelper {
  ApiBaseHelper([Client client]) {
    _client = client ?? Client();
  }

  Client _client;

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await _client.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await _client.post(url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server with statusCode : ${response.statusCode}');
    }
  }
}

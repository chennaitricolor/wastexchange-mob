//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1
import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/resources/auth_interceptor.dart';
import 'package:wastexchange_mobile/resources/log_interceptor.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/utils/logger.dart';

class ApiBaseHelper {
  ApiBaseHelper(
      {HttpClientWithInterceptor client,
      HttpClientWithInterceptor clientWithAuth}) {
    httpClientWithAuth = clientWithAuth ??
        HttpClientWithInterceptor.build(interceptors: [
          LogInterceptor(),
          AuthInterceptor(TokenRepository())
        ]);
    httpClient = client ??
        HttpClientWithInterceptor.build(interceptors: [LogInterceptor()]);
  }

  @visibleForTesting
  HttpClientWithInterceptor httpClientWithAuth;

  @visibleForTesting
  HttpClientWithInterceptor httpClient;

  final String _baseApiUrl = DotEnv().env['BASE_API_URL'];
  final logger = getLogger('ApiBaseHelper');

  HttpClientWithInterceptor _client(bool authenticated) =>
      authenticated ? httpClientWithAuth : httpClient;

  Future<dynamic> get(bool authenticated, String path) async {
    try {
      final response = await _client(authenticated).get(_baseApiUrl + path);
      return _returnResponse(response);
    } on SocketException {
      final ApiException exception =
          FetchDataException('No Internet connection');
      logger.e(exception);
      throw exception;
    }
  }

  Future<dynamic> post(bool authenticated, String path, dynamic body) async {
    try {
      final response = await _client(authenticated).post(_baseApiUrl + path,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      return _returnResponse(response);
    } on SocketException {
      final ApiException exception =
          FetchDataException('No Internet connection');
      logger.e(exception);
      throw exception;
    }
  }

  dynamic _returnResponse(Response response) {
    final String responseStr = response.body.toString();
    if (_isSuccessfulResponse(response)) {
      return responseStr;
    }
    handleUnsuccessfulStatusCode(response, responseStr);
  }

  bool _isSuccessfulResponse(Response response) {
    return response.statusCode >= Constants.SUCCESS &&
        response.statusCode < Constants.MULTIPLE_CHOICE;
  }

  void handleUnsuccessfulStatusCode(Response response, String responseStr) {
    switch (response.statusCode) {
      case Constants.BAD_REQUEST:
        final ApiException exception = BadRequestException(responseStr);
        logger.e(exception);
        throw exception;
      case Constants.UNAUTHORIZED:
      case Constants.FORBIDDEN:
        final ApiException exception = UnauthorisedException(responseStr);
        logger.e(exception);
        throw exception;
      case Constants.NOT_FOUND:
        final ApiException exception = ResourceNotFoundException(responseStr);
        logger.e(exception);
        throw exception;
      case Constants.INTERNAL_SERVER_ERROR:
      default:
        final ApiException exception = FetchDataException(
            'Error occured while communicating with server. StatusCode : ${response.statusCode}, Error: $responseStr');
        logger.e(exception);
        throw exception;
    }
  }
}

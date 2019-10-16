//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:wastexchange_mobile/resources/api_response_codes.dart';
import 'package:wastexchange_mobile/resources/auth_interceptor.dart';
import 'package:wastexchange_mobile/resources/env_repository.dart';
import 'package:wastexchange_mobile/resources/log_interceptor.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/resources/platform_info_repository.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';

class ApiBaseHelper {
  ApiBaseHelper(
      // TODO(Sayeed): Need to close the clients after completion of requests.
      {HttpClientWithInterceptor client,
      HttpClientWithInterceptor clientWithAuth,
      PlatformInfoRespository platformInfoRespository}) {
    httpClientWithAuth = clientWithAuth ??
        HttpClientWithInterceptor.build(interceptors: [
          LogInterceptor(),
          AuthInterceptor(TokenRepository())
        ]);
    httpClientWithAuth.requestTimeout = _requestTimeOut;
    httpClient = client ??
        HttpClientWithInterceptor.build(interceptors: [LogInterceptor()]);
    httpClient.requestTimeout = _requestTimeOut;

    _platformInfoRespository =
        platformInfoRespository ?? PlatformInfoRespositoryImpl();
  }

  @visibleForTesting
  HttpClientWithInterceptor httpClientWithAuth;

  @visibleForTesting
  HttpClientWithInterceptor httpClient;

  PlatformInfoRespository _platformInfoRespository;

  final _requestTimeOut = const Duration(seconds: 20);

  final String _baseApiUrl =
      EnvRepository().getValue(key: EnvRepository.baseApiUrl);

  final logger = AppLogger.get('ApiBaseHelper');

  HttpClientWithInterceptor _client(bool authenticated) =>
      authenticated ? httpClientWithAuth : httpClient;

  Future<String> getPlatformHeader() async {
    final platformInfo = _platformInfoRespository.getPlatformInfo();
    return '${platformInfo.appName}/${platformInfo.appVersion}(${platformInfo.appBuildNumber})/${platformInfo.platformOS}/${platformInfo.platformOSVersion}';
  }

  Future<dynamic> get(String path, {bool authenticated = true}) async {
    final String platformHeader = await getPlatformHeader();

    try {
      final response = await _client(authenticated).get(
        _baseApiUrl + path,
        headers: {
          'Content-Type': 'application/json',
          'x-wstexchng-platform': platformHeader
        },
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ConnectionTimeoutException('Connection timed out');
    }
  }

  Future<dynamic> put(bool authenticated, String path, dynamic body) async {
    final String platformHeader = await getPlatformHeader();

    try {
      final response = await _client(authenticated).put(_baseApiUrl + path,
          headers: {
            'Content-Type': 'application/json',
            'x-wstexchng-platform': platformHeader
          },
          body: json.encode(body));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ConnectionTimeoutException('Connection timed out');
    }
  }

  Future<dynamic> post(bool authenticated, String path, dynamic body) async {
    final String platformHeader = await getPlatformHeader();

    try {
      final response = await _client(authenticated).post(_baseApiUrl + path,
          headers: {
            'Content-Type': 'application/json',
            'x-wstexchng-platform': platformHeader
          },
          body: json.encode(body));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ConnectionTimeoutException('Connection timed out');
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
    return APIResponseCodes.SUCCESS <= response.statusCode &&
        response.statusCode < APIResponseCodes.MULTIPLE_CHOICE;
  }

  void handleUnsuccessfulStatusCode(Response response, String responseStr) {
    switch (response.statusCode) {
      case APIResponseCodes.BAD_REQUEST:
        final ApiException exception = BadRequestException(responseStr);
        logger.e(exception);
        throw exception;
      case APIResponseCodes.UNAUTHORIZED:
      case APIResponseCodes.FORBIDDEN:
        final ApiException exception = UnauthorisedException(responseStr);
        logger.e(exception);
        throw exception;
      case APIResponseCodes.NOT_FOUND:
        final ApiException exception = ResourceNotFoundException(responseStr);
        logger.e(exception);
        throw exception;
      case APIResponseCodes.INTERNAL_SERVER_ERROR:
      default:
        final ApiException exception = FetchDataException(
            'Error occured while communicating with server. StatusCode : ${response.statusCode}, Error: $responseStr');
        logger.e(exception);
        throw exception;
    }
  }
}

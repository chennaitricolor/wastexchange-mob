//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as flutter_http;
import 'package:wastexchange_mobile/models/app_error.dart';
import 'package:wastexchange_mobile/models/http_request_response.dart';
import 'package:wastexchange_mobile/models/http_response.dart';
import 'package:wastexchange_mobile/models/http_request.dart';
import 'package:wastexchange_mobile/resources/api_response_codes.dart';
import 'package:wastexchange_mobile/resources/http_status_codes.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class HttpClient {
  HttpClient({flutter_http.Client client}) {
    _client = client ?? flutter_http.Client();
  }

  flutter_http.Client _client;

  Future<HttpRequestResponse> get(HttpRequest httpRequest) async {
    assert(isNotNull(httpRequest));
    try {
      final response =
          await _client.get(httpRequest.url, headers: httpRequest.headers);
      return HttpRequestResponse(httpRequest, _httpResponseFrom(response));
    } on SocketException {
      return HttpRequestResponse(httpRequest, _noInternetError());
    }
  }

  Future<HttpRequestResponse> put(HttpRequest httpRequest) async {
    assert(isNotNull(httpRequest));
    try {
      final response = await _client.put(httpRequest.url,
          body: httpRequest.body, headers: httpRequest.headers);
      return HttpRequestResponse(httpRequest, _httpResponseFrom(response));
    } on SocketException {
      return HttpRequestResponse(httpRequest, _noInternetError());
    }
  }

  Future<HttpRequestResponse> post(HttpRequest httpRequest) async {
    assert(isNotNull(httpRequest));
    try {
      final response = await _client.post(httpRequest.url,
          body: httpRequest.body, headers: httpRequest.headers);
      return HttpRequestResponse(httpRequest, _httpResponseFrom(response));
    } on SocketException {
      return HttpRequestResponse(httpRequest, _noInternetError());
    }
  }

  HttpResponse _httpResponseFrom(flutter_http.Response response) {
    if (_isSuccessfulResponse(response)) {
      return HttpResponse.result(response.body.toString(), response.statusCode);
    }
    return _errorFromResponse(response);
  }

  bool _isSuccessfulResponse(flutter_http.Response response) {
    return APIResponseCodes.SUCCESS <= response.statusCode &&
        response.statusCode < APIResponseCodes.MULTIPLE_CHOICE;
  }

  HttpResponse _errorFromResponse(flutter_http.Response response) {
    final responseStr = response.body.toString();
    switch (response.statusCode) {
      case HttpStatusCodes.badRequest:
        return HttpResponse.error(
            HttpErrorBadRequest(responseStr), response.statusCode);
      case HttpStatusCodes.unauthorised:
      case HttpStatusCodes.forbidden:
        return HttpResponse.error(
            HttpErrorUnauthorised(responseStr), response.statusCode);
      case HttpStatusCodes.notFound:
        return HttpResponse.error(
            HttpErrorNotFound(responseStr), response.statusCode);
      case HttpStatusCodes.internalServerError:
      default:
        return HttpResponse.error(
            HttpErrorFetchData(responseStr), response.statusCode);
    }
  }

  HttpResponse _noInternetError() {
    return HttpResponse.error(HttpErrorNoInternet('No Internet connection'),
        HttpStatusCodes.serviceUnavailable);
  }
}

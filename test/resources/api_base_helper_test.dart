
import 'dart:collection';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class MockHttpClient extends Mock implements HttpClientWithInterceptor {

}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {

}

///Test case to check reading and writing flutter secure storage.
void main() {

  final Map<String,String> envValues = HashMap<String,String>();
  envValues['MAPS_API_KEY'] = 'abc';
  envValues['BASE_API_URL'] = 'http://127.0.0.1:7000';
  envValues['LOGGER_LEVEL'] = 'debug';
  DotEnv(env: envValues);

  final MockHttpClient _mockHttpClient = MockHttpClient();

  final _baseUrl = DotEnv().env['BASE_API_URL'];

  test('Test GET call throw Exception on 503 response', () async {

    final String path = 'login';
    when(_mockHttpClient.get(_baseUrl + path)).thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 503));

    final ApiBaseHelper apiBaseHelper = ApiBaseHelper(httpClient: _mockHttpClient);

    expect(apiBaseHelper.get(false, path), throwsA(const TypeMatcher<ApiException>()));
  });

  test('Test POST call with json gives proper body on success response', () async {
    final String path = 'login';
    final String body = '{"email":"email@email.com", "otp":"1234"}';

    ApiBaseHelper apiBaseHelper = ApiBaseHelper(httpClient: _mockHttpClient);

    when(_mockHttpClient.post(_baseUrl + path, headers: {'Content-Type': 'application/json'},
        body: json.encode(body))).thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 200));

    expect((await apiBaseHelper.post(false, path, body)).toString(), '{"auth":true,"token":"token"}');
  });

  test('Test POST call with json throw Exceptions on Bad Responses response', () async {

    final String path = 'login';
    final String body = '{"email":"email@email.com", "otp":"1234"}';

    ApiBaseHelper apiBaseHelper = ApiBaseHelper(httpClient: _mockHttpClient);

    when(_mockHttpClient.post(_baseUrl + path, headers: {'Content-Type': 'application/json'},
        body: json.encode(body))).thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 503));

    expect(apiBaseHelper.post(false, path, body), throwsA(const TypeMatcher<ApiException>()));

    when(_mockHttpClient.post(_baseUrl + path, headers: {'Content-Type': 'application/json'},
        body: json.encode(body))).thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 401));

    expect(apiBaseHelper.post(false, path, body), throwsA(const TypeMatcher<UnauthorisedException>()));

    when(_mockHttpClient.post(_baseUrl + path, headers: {'Content-Type': 'application/json'},
        body: json.encode(body))).thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 404));

    expect(apiBaseHelper.post(false, path, body), throwsA(const TypeMatcher<ResourceNotFoundException>()));

    when(_mockHttpClient.post(_baseUrl + path, headers: {'Content-Type': 'application/json'},
        body: json.encode(body))).thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 400));

    expect(apiBaseHelper.post(false, path, body), throwsA(const TypeMatcher<BadRequestException>()));

  });
}

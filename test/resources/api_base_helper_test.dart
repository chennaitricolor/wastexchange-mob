import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wastexchange_mobile/resources/auth_interceptor.dart';
import 'package:wastexchange_mobile/resources/log_interceptor.dart';

class MockHttpClient extends Mock implements HttpClientWithInterceptor {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

///Test case to check reading and writing flutter secure storage.
void main() {
  MockHttpClient _mockHttpClient;
  ApiBaseHelper _apiBaseHelper;
  String _baseUrl;

  setUp(() {
    DotEnv(env: {
      'BASE_API_URL': 'http://127.0.0.1:7000',
      'LOGGER_LEVEL': 'debug'
    });
    _baseUrl = DotEnv().env['BASE_API_URL'];
    _mockHttpClient = MockHttpClient();
    _apiBaseHelper =
        ApiBaseHelper(client: _mockHttpClient, clientWithAuth: _mockHttpClient);
  });

  test('Test APIBaseHelper initialize http clients', () async {
    final ApiBaseHelper helper = ApiBaseHelper();

    expect(helper.httpClient, isNotNull);
    expect(helper.httpClientWithAuth, isNotNull);
    expect(helper.httpClient.interceptors.length, 1);
    expect(
        helper.httpClient.interceptors[0], const TypeMatcher<LogInterceptor>());
    expect(helper.httpClientWithAuth.interceptors.length, 2);
    expect(helper.httpClientWithAuth.interceptors[1],
        const TypeMatcher<AuthInterceptor>());
  });

  test('Test GET call throw Exception on 503 response', () async {
    const String path = 'login';
    when(_mockHttpClient.get(_baseUrl + path)).thenAnswer(
        (_) async => http.Response('{"auth":true,"token":"token"}', 503));

    expect(_apiBaseHelper.get(false, path),
        throwsA(const TypeMatcher<ApiException>()));
  });

  test('Test GET call throw FetchData exception on Socket Exception', () async {
    const String path = 'login';
    when(_mockHttpClient.get(_baseUrl + path)).thenAnswer((_) => Future(() {
          throw const SocketException('');
        }));

    expect(_apiBaseHelper.get(false, path),
        throwsA(const TypeMatcher<FetchDataException>()));
  });

  test('Test POST call throw FetchData exception on Socket Exception',
      () async {
    const String path = 'login';
    when(_mockHttpClient.post(_baseUrl + path,
            headers: {'Content-Type': 'application/json'},
            body: json.encode('{}')))
        .thenAnswer((_) => Future(() {
              throw const SocketException('');
            }));

    expect(_apiBaseHelper.post(false, path, '{}'),
        throwsA(const TypeMatcher<FetchDataException>()));
  });

  test('Test POST call with json gives proper body on success response',
      () async {
    const String path = 'login';
    const String body = '{"email":"email@email.com", "otp":"1234"}';

    when(_mockHttpClient.post(_baseUrl + path,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body)))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 200));

    expect((await _apiBaseHelper.post(false, path, body)).toString(),
        '{"auth":true,"token":"token"}');
  });

  test('Test POST call with json throw Exceptions on Bad Responses response',
      () async {
    const String path = 'login';
    const String body = '{"email":"email@email.com", "otp":"1234"}';

    when(_mockHttpClient.post(_baseUrl + path,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body)))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 503));

    expect(_apiBaseHelper.post(false, path, body),
        throwsA(const TypeMatcher<ApiException>()));

    when(_mockHttpClient.post(_baseUrl + path,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body)))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 401));

    expect(_apiBaseHelper.post(false, path, body),
        throwsA(const TypeMatcher<UnauthorisedException>()));

    when(_mockHttpClient.post(_baseUrl + path,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body)))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 404));

    expect(_apiBaseHelper.post(false, path, body),
        throwsA(const TypeMatcher<ResourceNotFoundException>()));

    when(_mockHttpClient.post(_baseUrl + path,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body)))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 400));

    expect(_apiBaseHelper.post(false, path, body),
        throwsA(const TypeMatcher<BadRequestException>()));
  });
}

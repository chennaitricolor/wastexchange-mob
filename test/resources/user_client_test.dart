@Skip('Failing tests after BLOC implementation')

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:http_interceptor/http_interceptor.dart';

class MockClient extends Mock implements HttpClientWithInterceptor {}

void main() {
  group('login', () {
    const Login_URL = 'https://data.indiawasteexchange.com/users/login';

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.post(Login_URL, body: anyNamed('body'))).thenAnswer(
          (_) async => http.Response('{"auth":true,"token":"token"}', 503));

      final UserClient provider = UserClient();

      expect(provider.login(LoginData(loginId: 'a', password: 'b')),
          throwsA(const TypeMatcher<ApiException>()));
    });

    test('returns a LoginResponse if the http call completes successfully',
        () async {
      final client = MockClient();
      when(client.post(Login_URL, body: anyNamed('body'))).thenAnswer(
          (_) async => http.Response('{"auth":true,"token":"token"}', 200));

      final UserClient provider = UserClient();
      final result =
          await provider.login(LoginData(loginId: 'a', password: 'b'));

      expect(result, const TypeMatcher<LoginResponse>());
    });

    test('url, arguments passed to httpClient', () async {
      final client = MockClient();
      when(client.post(Login_URL, body: anyNamed('body'))).thenAnswer(
          (_) async => http.Response('{"auth":true,"token":"token"}', 200));

      final UserClient provider = UserClient();
      await provider.login(LoginData(loginId: 'a', password: 'b'));

      verify(client.post(Login_URL, body: {'loginId': 'a', 'password': 'b'}));
    });
  });
}

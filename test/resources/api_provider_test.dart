import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_request.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/resources/api_provider.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  test('non 200 status code', () {
    final client = MockClient();
    when(client.post(Constants.URL_LOGIN,
            body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 201));

    ApiProvider provider = ApiProvider(client);

    expect(() => provider.login(LoginRequest(loginId: 'a', password: 'b')),
        throwsA(TypeMatcher<ApiResponseException>()));
  });

  test('200 status code', () {
    final client = MockClient();
    when(client.post(Constants.URL_LOGIN,
            body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 200));

    ApiProvider provider = ApiProvider(client);

    expect(provider.login(LoginRequest(loginId: 'a', password: 'b')), completion(TypeMatcher<LoginResponse>()));
  });

/* //TODO: Fix it.
  test('args', () {
    final client = MockClient();
    when(client.post(Constants.URL_LOGIN,
            body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 200));

    ApiProvider provider = ApiProvider(client);
   
    expect(
        provider.login('a', 'b'),
        completion(verify(client.post(
            Constants.URL_LOGIN,
            body: {'loginId': 'a', 'passowrd': 'b'}))));
  });
  */
}

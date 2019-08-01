import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/resources/api_provider.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  test('non 200 status code', () {
    final client = MockClient();
    when(client.post('http://data.indiawasteexchange.com/users/login',
            body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 201));

    ApiProvider provider = ApiProvider(client);

    expect(() => provider.login('a', 'b'),
        throwsA(TypeMatcher<ApiResponseException>()));
  });

  test('200 status code', () {
    final client = MockClient();
    when(client.post('http://data.indiawasteexchange.com/users/login',
            body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 200));

    ApiProvider provider = ApiProvider(client);

    expect(provider.login('a', 'b'), completion(TypeMatcher<LoginResponse>()));
  });

/* //TODO: Fix it.
  test('args', () {
    final client = MockClient();
    when(client.post('http://data.indiawasteexchange.com/users/login',
            body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('{"auth":true,"token":"token"}', 200));

    ApiProvider provider = ApiProvider(client);
   
    expect(
        provider.login('a', 'b'),
        completion(verify(client.post(
            'http://data.indiawasteexchange.com/users/login',
            body: {'loginId': 'a', 'passowrd': 'b'}))));
  });
  */
}

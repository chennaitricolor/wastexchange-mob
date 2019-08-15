import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class MockApiHelper extends Mock implements ApiBaseHelper {}

void main() {

  group('login', () {

    test('throws an exception if the http call completes with an error', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      when(mockApiHelper.post(false, UserClient.PATH_LOGIN, LoginData(loginId: 'a', password: 'b').toMap())).thenThrow(ApiException());

      final UserClient provider = UserClient(mockApiHelper);

      expect(provider.login(LoginData(loginId: 'a', password: 'b')), throwsA(const TypeMatcher<ApiException>()));
    });

    test('returns a LoginResponse if the http call completes successfully', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      when(mockApiHelper.post(false, UserClient.PATH_LOGIN, LoginData(loginId: 'a', password: 'b').toMap())).thenAnswer(
          (_) async => '{"auth":true,"token":"token"}');

      final UserClient provider = UserClient(mockApiHelper);
      final result =
          await provider.login(LoginData(loginId: 'a', password: 'b'));

      expect(result, const TypeMatcher<LoginResponse>());
    });
  });
}

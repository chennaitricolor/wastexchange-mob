import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:test/test.dart';

void main() {
  test('auth key missing', () {
    expect(() => LoginResponse.fromJson({'token': 'blah'}),
        throwsA(const TypeMatcher<ApiResponseException>()));
  });

  test('token key missing', () {
    expect(() => LoginResponse.fromJson({'auth': true}),
        throwsA(const TypeMatcher<ApiResponseException>()));
  });

  test('valid', () {
    expect(LoginResponse.fromJson({'auth': true, 'token': 'blah'}),
        const TypeMatcher<LoginResponse>());
  });
}

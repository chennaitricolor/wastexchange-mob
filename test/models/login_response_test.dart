import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:test/test.dart';

void main() {
  test('auth key missing', () {
    expect(() => LoginResponse.fromJson({'token': 'blah'}),
        throwsA(const TypeMatcher<ArgumentError>()));
  });

  test('token key missing', () {
    expect(() => LoginResponse.fromJson({'auth': true}),
        throwsA(const TypeMatcher<ArgumentError>()));
  });

  test('valid', () {
    expect(LoginResponse.fromJson({'auth': true, 'token': 'blah'}),
        const TypeMatcher<LoginResponse>());
  });
}

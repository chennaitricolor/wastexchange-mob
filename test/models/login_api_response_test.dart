import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:test/test.dart';

void main() {
  test('auth key missing', () {
    var map = Map<String, dynamic>();
    map['token'] = 'Blah';
    expect(() => LoginResponse.fromJson(map),
        throwsA(const TypeMatcher<ApiResponseException>())); 
  });

  test('token key missing', () {
    var map = Map<String, dynamic>();
    map['auth'] = true;
    expect(() => LoginResponse.fromJson(map),
        throwsA(const TypeMatcher<ApiResponseException>())); 
  });

  test('valid', () {
    var map = Map<String, dynamic>();
    map['auth'] = true;
    map['token'] = 'Blah';
    expect(LoginResponse.fromJson(map), TypeMatcher<LoginResponse>());
  });
}

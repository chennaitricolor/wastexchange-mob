  import 'package:flutter_test/flutter_test.dart';
  import 'package:wastexchange_mobile/models/login_response.dart';

  void main() {

    test('auth key missing', () {
      var map = Map<String, dynamic>();
      map['token'] = 'Blah';
      expect(() => LoginResponse.fromJson(map), throwsException); //TODO: Try to get throwsA(TypeMatcher<ApiResponseException>() to work
    });

      test('token key missing', () {
      var map = Map<String, dynamic>();
      map['auth'] = true;
      expect(() => LoginResponse.fromJson(map), throwsException); //TODO: Try to get throwsA(TypeMatcher<ApiResponseException>() to work
    });

      test('valid', () {
      var map = Map<String, dynamic>();
      map['auth'] = true;
      map['token'] = 'Blah';
      expect(() => LoginResponse.fromJson(map), returnsNormally);
    });

  }
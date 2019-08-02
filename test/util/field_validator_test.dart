import 'package:flutter_test/flutter_test.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';  

void main() {
  test('empty password', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Password cannot be empty', );
  });

  test('password < 5 chars', () {
    var result = FieldValidator.validatePassword('abc');
    expect(result, 'Password must be more than 5 characters');
  });

  test('password >= 5 chars', () {
    var result = FieldValidator.validatePassword('abcdefg');
    expect(result, null);
  });

}
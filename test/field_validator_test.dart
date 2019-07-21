import 'package:flutter_test/flutter_test.dart';
import 'package:wastexchange_mobile/field_validator.dart';  

void main() {
  test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Password cannot be empty', );
  });

  test('Password < 7 Characters Tests', () {
    var result = FieldValidator.validatePassword('abcdef');
    expect(result, 'Password must be more than 6 characters');
  });

  test('Password >= 7 Characters Tests', () {
    var result = FieldValidator.validatePassword('abcdefg');
    expect(result, null);
  });

}
import 'package:flutter_test/flutter_test.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';

void main() {
  group('Password Field Tests', () {
    test('GIVEN value WHEN password is null THEN should show error', () {
      final result = FieldValidator.validatePassword(null);
      expect(
        result,
        'Password cannot be empty',
      );
    });

    test('GIVEN value WHEN password is empty THEN should show error', () {
      final result = FieldValidator.validatePassword('');
      expect(
        result,
        'Password cannot be empty',
      );
    });

    test('GIVEN value WHEN password is < 5 THEN should show error', () {
      final result = FieldValidator.validatePassword('abc');
      expect(result, 'Password must be more than 4 characters');
    });

    test(
        'GIVEN value WHEN password is valid THEN should validate password successfully',
        () {
      final result = FieldValidator.validatePassword('abcdefg');
      expect(result, null);
    });
  });

  group('Confirm Password Field Tests', () {
    test(
        'GIVEN value WHEN password and confirm password are null THEN should show error',
        () {
      final result = FieldValidator.validateConfirmPassword(null, null);
      expect(
        result,
        'Confirm Password cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN password and confirm password are empty THEN should show error',
        () {
      final result = FieldValidator.validateConfirmPassword('', '');
      expect(
        result,
        'Confirm Password cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN password is valid and confirm password is empty THEN should show error',
        () {
      final result = FieldValidator.validateConfirmPassword('123456', '');
      expect(
        result,
        'Confirm Password cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN password and confirm password are not matching THEN should show error',
        () {
      final result = FieldValidator.validateConfirmPassword('123456', '123457');
      expect(
        result,
        'Confirm Password must be same as Password',
      );
    });

    test(
        'GIVEN value WHEN password and confirm password matches THEN should validate confirm password successfully',
        () {
      final result = FieldValidator.validateConfirmPassword('123456', '123456');
      expect(result, null);
    });
  });

  group('Email Field Tests', () {
    test('GIVEN value WHEN email is null THEN should show error', () {
      final result = FieldValidator.validateEmailAddress(null);
      expect(
        result,
        'Email cannot be empty',
      );
    });

    test('GIVEN value WHEN email is empty THEN should show error', () {
      final result = FieldValidator.validateEmailAddress('');
      expect(
        result,
        'Email cannot be empty',
      );
    });

    test('GIVEN value WHEN email is without @ symbol THEN should show error',
        () {
      final result = FieldValidator.validateEmailAddress('abcxyz.com');
      expect(result, 'Please enter a valid Email');
    });

    test('GIVEN value WHEN email is without domain THEN should show error', () {
      final result = FieldValidator.validateEmailAddress('abc@xyz');
      expect(result, 'Please enter a valid Email');
    });

    test(
        'GIVEN value WHEN email is valid THEN should validate password successfully',
        () {
      final result = FieldValidator.validateEmailAddress('abc@xyz.com');
      expect(result, null);
    });
  });

// TODO(Sayeed): Figure out the best practice for naming and grouping flutter tests
  group('Mobile Field Tests', () {
    test('GIVEN value WHEN mobile number is null THEN should show error', () {
      final result = FieldValidator.validateMobileNumber(null);
      expect(
        result,
        'Mobile number cannot be empty',
      );
    });

    test('GIVEN value WHEN mobile number is empty THEN should show error', () {
      final result = FieldValidator.validateMobileNumber('');
      expect(
        result,
        'Mobile number cannot be empty',
      );
    });

    test('GIVEN value WHEN mobile number is < 10 THEN should show error', () {
      final result = FieldValidator.validateMobileNumber('998877665');
      expect(result, 'Mobile number must be minimum 10 digits');
    });

    test(
        'GIVEN value WHEN mobile number has characters other than digits [0-9] THEN should show error',
        () {
      final result = FieldValidator.validateMobileNumber('+998877666');
      expect(result, 'Mobile number must contain digits');
    });

    test(
        'GIVEN value WHEN mobile number is valid THEN should validate mobile number successfully',
        () {
      final result = FieldValidator.validateMobileNumber('9988776655');
      expect(result, null);
    });
  });

  group('Alternate Mobile Field Tests', () {
    test(
        'GIVEN value WHEN alternate mobile number is null THEN should show error',
        () {
      final result = FieldValidator.validateAlternateMobileNumber(null, '123');
      expect(
        result,
        'Mobile number cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN alternate mobile number is empty THEN should show error',
        () {
      final result = FieldValidator.validateAlternateMobileNumber('', '123');
      expect(
        result,
        'Mobile number cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN alternate mobile number is < 10 THEN should show error',
        () {
      final result =
          FieldValidator.validateAlternateMobileNumber('998877665', '123');
      expect(result, 'Mobile number must be minimum 10 digits');
    });

    test(
        'GIVEN value WHEN alternate mobile number has characters other than digits [0-9] THEN should show error',
        () {
      final result =
          FieldValidator.validateAlternateMobileNumber('+998877666', '123');
      expect(result, 'Mobile number must contain digits');
    });

    test(
        'GIVEN value WHEN alternate mobile number is same as mobile number THEN should show error',
        () {
      final result = FieldValidator.validateAlternateMobileNumber(
          '9988776651', '9988776651');
      expect(result, 'Mobile and Alternate Mobile are same');
    });

    test(
        'GIVEN value WHEN alternate mobile number is valid THEN should validate mobile number successfully',
        () {
      final result =
          FieldValidator.validateAlternateMobileNumber('9988776655', '123');
      expect(result, null);
    });
  });

  group('Name Field Tests', () {
    test('GIVEN value WHEN name is null THEN should show error', () {
      final result = FieldValidator.validateName(null);
      expect(
        result,
        'Name cannot be empty',
      );
    });

    test('GIVEN value WHEN name is empty THEN should show error', () {
      final result = FieldValidator.validateName('');
      expect(
        result,
        'Name cannot be empty',
      );
    });

    test('GIVEN value WHEN name has special characters THEN should show error',
        () {
      final result = FieldValidator.validateName('Sayeed#');
      expect(
        result,
        'Name cannot have special characters',
      );
    });

    test(
        'GIVEN value WHEN name is valid THEN should validate name successfully',
        () {
      final result = FieldValidator.validateName('abcd');
      expect(result, null);
    });
  });

  group('Address Field Tests', () {
    test('GIVEN value WHEN address is null THEN should show error', () {
      final result = FieldValidator.validateAddress(null);
      expect(
        result,
        'Address cannot be empty',
      );
    });

    test('GIVEN value WHEN address is empty THEN should show error', () {
      final result = FieldValidator.validateAddress('');
      expect(
        result,
        'Address cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN address is valid THEN should validate address successfully',
        () {
      final result = FieldValidator.validateAddress('abcd');
      expect(result, null);
    });
  });

  group('City Field Tests', () {
    test('GIVEN value WHEN city is null THEN should show error', () {
      final result = FieldValidator.validateCity(null);
      expect(
        result,
        'City cannot be empty',
      );
    });

    test('GIVEN value WHEN city is empty THEN should show error', () {
      final result = FieldValidator.validateCity('');
      expect(
        result,
        'City cannot be empty',
      );
    });

    test(
        'GIVEN value WHEN city is valid THEN should validate city successfully',
        () {
      final result = FieldValidator.validateCity('abcd');
      expect(result, null);
    });
  });

  group('Pincode Field Tests', () {
    test('GIVEN value WHEN pincode is null THEN should show error', () {
      final result = FieldValidator.validatePincode(null);
      expect(
        result,
        'Pincode cannot be empty',
      );
    });

    test('GIVEN value WHEN pincode is empty THEN should show error', () {
      final result = FieldValidator.validatePincode('');
      expect(
        result,
        'Pincode cannot be empty',
      );
    });

    test('GIVEN value WHEN pincode.length != 6 THEN should show error', () {
      final result = FieldValidator.validatePincode('abcd');
      expect(result, 'Pincode should be 6 digits');
    });

    test(
        'GIVEN value WHEN pincode is valid THEN should validate pincode successfully',
        () {
      final result = FieldValidator.validatePincode('600054');
      expect(result, null);
    });
  });

  group('OTP Field Tests', () {
    test('GIVEN value WHEN otp is null THEN should show error', () {
      final result = FieldValidator.validateOTP(null);
      expect(
        result,
        'OTP cannot be empty',
      );
    });

    test('GIVEN value WHEN otp is empty THEN should show error', () {
      final result = FieldValidator.validateOTP('');
      expect(
        result,
        'OTP cannot be empty',
      );
    });

    test('GIVEN value WHEN otp is valid THEN should validate otp successfully',
        () {
      final result = FieldValidator.validateOTP('1234');
      expect(result, null);
    });
  });
}

// TODO(Sayeed): Consider renaming this class for readability
class FieldValidator {
  static bool isNullOrEmpty(String o) => o == null || '' == o;

  static String validateName(String value) {
    if (isNullOrEmpty(value)) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static String validateAddress(String value) {
    if (isNullOrEmpty(value)) {
      return 'Address cannot be empty';
    }
    return null;
  }

  static String validateCity(String value) {
    if (isNullOrEmpty(value)) {
      return 'City cannot be empty';
    }
    return null;
  }

  static String validatePincode(String value) {
    if (isNullOrEmpty(value)) {
      return 'Pincode cannot be empty';
    }
    if (value.length != 6) {
      return 'Pincode should be 6 digits';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (isNullOrEmpty(value)) {
      return 'Password cannot be empty';
    }
    if (value.length < 5) {
      return 'Password must be more than 4 characters';
    }
    return null;
  }

  static String validateConfirmPassword(
      String password, String confirmPassword) {
    if (isNullOrEmpty(confirmPassword)) {
      return 'Confirm Password cannot be empty';
    }
    if (password != confirmPassword) {
      return 'Confirm Password must be same as Password';
    }
    return null;
  }

  static String validateEmailAddress(String value) {
    if (isNullOrEmpty(value)) {
      return 'Email cannot be empty';
    }
    final bool emailValid =
        RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value);

    return !emailValid ? 'Please enter a valid Email' : null;
  }

  static String validateMobileNumber(String value) {
    if (isNullOrEmpty(value)) {
      return 'Mobile number cannot be empty';
    }
    if (value.length < 10) {
      return 'Mobile number must be minimum 10 digits';
    }
    return null;
  }

  static String validateOTP(String value) {
    if (isNullOrEmpty(value)) {
      return 'OTP cannot be empty';
    }
    return null;
  }
}

class FieldValidator {

  static String validateName(String value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static String validateAddress(String value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }
    return null;
  }

  static String validateCity(String value) {
    if (value == null || value.isEmpty) {
      return 'City cannot be empty';
    }
    return null;
  }

  static String validatePincode(String value) {
    if (value == null || value.isEmpty) {
      return 'Pincode cannot be empty';
    }
    if (value.length < 5) {
      return 'Pincode should be minimum 5 digits';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 5) {
      return 'Password must be more than 5 characters';
    }
    return null;
  }

  static String validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (password != confirmPassword) {
      return 'Confirm Password must be same as password';
    }
    return null;
  }

  static String validateEmailAddress(String value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (value.length < 5) {
      return 'Email must be more than 5 characters';
    }

    final bool emailValid = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value);
    if (!emailValid) {
       return 'Please enter the valid email id';
    }
    return null;
  }

  static String validateMobileNumber(String value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    }
    if (value.length < 10) {
      return 'Mobile number must be minimum 10 digits';
    }
    return null;
  }

  static String validateOTP(String value) {
    if (value == null || value.isEmpty) {
      return 'OTP cannot be empty';
    }
    return null;
  }
}

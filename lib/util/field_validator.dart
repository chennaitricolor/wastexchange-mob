class FieldValidator {
  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 5) {
      return 'Password must be more than 5 characters';
    }
    return null;
  }

  static String validateEmailAddress(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (value.length < 5) {
      return 'Email must be more than 5 characters';
    }
    return null;
  }
}

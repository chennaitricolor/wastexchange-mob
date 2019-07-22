class FieldValidator {

  static String validatePassword(String value) {
    if (value.isEmpty) return "Password cannot be empty";
    if (value.length < 7) return "Password must be more than 6 characters";
    return null;
  }

}
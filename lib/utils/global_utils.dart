  bool isNullOrEmpty(String value) => value == null || value.isEmpty;

  bool isNotNullOrEmpty(String value) => value != null && value.isNotEmpty;

  bool isZero(String value) => value == '0';

  bool isDouble(String value) => double.tryParse(value) != null;
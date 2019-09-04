  bool isNullOrEmpty(String value) => value == null || value.isEmpty;

  bool isListNullOrEmpty(List value) => value == null || value.isEmpty;

  bool isMapNullOrEmpty(Map value) => value == null || value.isEmpty;

  bool isValidIndex(int size, int index) => index < size;

  bool isInValidIndex(int size, int index) => index >= size;

  bool isNotNullOrEmpty(String value) => value != null && value.isNotEmpty;

  bool isZero(String value) => value == '0';

  bool isDouble(String value) => double.tryParse(value) != null;
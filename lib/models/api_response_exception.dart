class ApiResponseException implements Exception {
  ApiResponseException(this.cause);
  final String cause;
}

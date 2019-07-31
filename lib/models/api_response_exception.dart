class ApiResponseException implements Exception {
  final String cause;
  ApiResponseException({this.cause});
}
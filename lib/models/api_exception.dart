//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

class ApiException implements Exception {
  ApiException([this._message, this._prefix]);

  final String _message;
  final String _prefix;

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException([String message]) : super(message, 'Invalid Input: ');
}

class InvalidResponseJSONException extends ApiException {
  InvalidResponseJSONException([String message])
      : super(message, 'Invalid Response JSON: ');
}

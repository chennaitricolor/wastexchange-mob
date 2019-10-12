class AppError {
  AppError([this.message, this._prefix]);

  final String message;
  final String _prefix;

  @override
  String toString() {
    return '${_prefix ?? ''} $message';
  }
}

class HttpErrorFetchData extends AppError {
  HttpErrorFetchData([String message])
      : super(message, 'Error During Communication: ');
}

class HttpErrorBadRequest extends AppError {
  HttpErrorBadRequest([message]) : super(message, 'Invalid Request: ');
}

class HttpErrorUnauthorised extends AppError {
  HttpErrorUnauthorised([message]) : super(message, 'Unauthorised: ');
}

class HttpErrorInvalidInput extends AppError {
  HttpErrorInvalidInput([String message]) : super(message, 'Invalid Input: ');
}

class HttpErrorNotFound extends AppError {
  HttpErrorNotFound([String message]) : super(message, 'Not Found: ');
}

class HttpErrorNoInternet extends AppError {
  HttpErrorNoInternet([String message]) : super(message, '');
}

class JsonParseError extends AppError {
  JsonParseError([String message]) : super(message, 'Invalid Json: ');
}

class HttpResponse<Data, Error> {
  HttpResponse.error(this.error, this.statusCode);
  HttpResponse.result(this.data, this.statusCode);
  Data data;
  Error error;
  int statusCode;
  bool get hasData => data != null;
  bool get hasError => error != null;
}

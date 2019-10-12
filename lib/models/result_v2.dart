class ResultV2<Data, Error> {
  ResultV2.data(this.data);
  ResultV2.error(this.error);
  Data data;
  Error error;
  bool get hasData => data != null;
  bool get hasError => error != null;
}

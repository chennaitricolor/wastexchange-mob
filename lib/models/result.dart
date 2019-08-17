//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

enum Status { LOADING, ERROR, COMPLETED }

class Result<T> {
  Result.loading(this.message) : status = Status.LOADING;
  Result.error(this.message) : status = Status.ERROR;
  Result.completed(this.data) : status = Status.COMPLETED;

  Status status;
  T data;
  String message;
}

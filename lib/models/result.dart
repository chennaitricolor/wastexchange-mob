//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

enum Status { loading, error, completed }

class Result<T> {
  Result.loading(this.message) : status = Status.loading;
  Result.error(this.message) : status = Status.error;
  Result.completed(this.data) : status = Status.completed;

  Status status;
  T data;
  String message;
}

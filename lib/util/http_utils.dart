class HttpUtils {
  static bool isSuccessfulResponse(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }
}

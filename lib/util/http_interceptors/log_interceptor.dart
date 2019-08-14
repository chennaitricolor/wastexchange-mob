import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter/widgets.dart';

///
/// Interceptor for debug purpose.
///
class LogInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    printRequestLog(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    printResponseLog(data);
    return data;
  }

  void printRequestLog(RequestData data) {
    debugPrint('Method: ${data.method}');
    debugPrint('Url: ${data.url}');
    debugPrint('Body: ${data.body}');
    debugPrint('Headers: ${data.headers}');
  }

  void printResponseLog(ResponseData data) {
    debugPrint('Status Code: ${data.statusCode}');
    debugPrint('Method: ${data.method}');
    debugPrint('Url: ${data.url}');
    debugPrint('Body: ${data.body}');
    debugPrint('Headers: ${data.headers}');
  }
}
import 'package:http_interceptor/http_interceptor.dart';

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
    print('Method: ${data.method}');
    print('Url: ${data.url}');
    print('Body: ${data.body}');
  }

  void printResponseLog(ResponseData data) {
    print('Status Code: ${data.statusCode}');
    print('Method: ${data.method}');
    print('Url: ${data.url}');
    print('Body: ${data.body}');
    print('Headers: ${data.headers}');
  }
}
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/util/logger.dart';
///
/// Interceptor for debug purpose.
///
class LogInterceptor implements InterceptorContract {

  final logger = getLogger('LogInterceptor');

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
    logger.d('Method: ${data.method}');
    logger.d('Url: ${data.url}');
    logger.d('Body: ${data.body}');
    logger.d('Headers: ${data.headers}');
  }

  void printResponseLog(ResponseData data) {
    logger.d('Status Code: ${data.statusCode}');
    logger.d('Method: ${data.method}');
    logger.d('Url: ${data.url}');
    logger.d('Body: ${data.body}');
    logger.d('Headers: ${data.headers}');
  }
}
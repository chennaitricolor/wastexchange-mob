import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/resources/log_interceptor.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockFlutterStorage extends Mock implements FlutterSecureStorage {}

class MockRequest extends Mock implements Request {}

class MockResponse extends Mock implements Response {}

void main() {
  LogInterceptor logInterceptor;

  setUp(() {
    logInterceptor = LogInterceptor();
  });

  test('check interceptRequest does not modify original data', () async {
    final MockRequest mockRequest = MockRequest();

    final RequestData requestData = RequestData.fromHttpRequest(mockRequest);
    final RequestData interceptedData =
        await logInterceptor.interceptRequest(data: requestData);

    expect(interceptedData, requestData);
  });

  test('check interceptResponse does not modify original data', () async {
    final MockResponse mockResponse = MockResponse();
    final MockRequest mockRequest = MockRequest();

    when(mockRequest.url).thenReturn(Uri.parse('http://localhost'));
    when(mockResponse.request).thenReturn(mockRequest);
    when(mockResponse.statusCode).thenReturn(401);

    final ResponseData responseData =
        ResponseData.fromHttpResponse(mockResponse);
    final ResponseData interceptedResponse =
        await logInterceptor.interceptResponse(data: responseData);

    expect(interceptedResponse, responseData);
  });
}

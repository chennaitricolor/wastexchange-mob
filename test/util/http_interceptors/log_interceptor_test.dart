import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/utils/http_interceptors/log_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
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
    MockRequest mockRequest = MockRequest();

    RequestData requestData = RequestData.fromHttpRequest(mockRequest);
    RequestData interceptedData =
        await logInterceptor.interceptRequest(data: requestData);

    expect(interceptedData, requestData);
  });

  test('check interceptResponse does not modify original data', () async {
    MockResponse mockResponse = MockResponse();
    MockRequest mockRequest = MockRequest();

    when(mockRequest.url).thenReturn(Uri.parse('http://localhost'));
    when(mockResponse.request).thenReturn(mockRequest);
    when(mockResponse.statusCode).thenReturn(401);

    ResponseData responseData = ResponseData.fromHttpResponse(mockResponse);
    ResponseData interceptedResponse =
        await logInterceptor.interceptResponse(data: responseData);

    expect(interceptedResponse, responseData);
  });
}

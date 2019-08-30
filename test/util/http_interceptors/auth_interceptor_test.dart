import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/utils/http_interceptors/auth_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wastexchange_mobile/utils/cached_secure_storage.dart';

class MockFlutterStorage extends Mock implements FlutterSecureStorage {}

class MockRequest extends Mock implements Request {}

class MockResponse extends Mock implements Response {}

void main() {
  AuthInterceptor authInterceptor;
  TokenRepository tokenRepository;

  setUp(() {
    tokenRepository =
        TokenRepository.testInit(CachedSecureStorage(MockFlutterStorage()));
    authInterceptor = AuthInterceptor(tokenRepository);
  });

  test(
      'check interceptRequest adding token to header WHEN TokenRepository returns token',
      () async {
    final MockRequest mockRequest = MockRequest();

    await tokenRepository.setToken('abbc');

    final RequestData requestData = RequestData.fromHttpRequest(mockRequest);
    await authInterceptor.interceptRequest(data: requestData);

    expect(requestData.headers['Authorization'], 'Bearer abbc');
  });

  test(
      'check interceptResponse clearing token in TokenRepository WHEN response returns 401 or 403',
      () async {
    await tokenRepository.setToken('abbc');
    expect(await tokenRepository.getToken(), 'abbc');

    final MockResponse mockResponse = MockResponse();
    final MockRequest mockRequest = MockRequest();

    when(mockRequest.url).thenReturn(Uri.parse('http://localhost'));
    when(mockResponse.request).thenReturn(mockRequest);
    when(mockResponse.statusCode).thenReturn(401);

    ResponseData responseData = ResponseData.fromHttpResponse(mockResponse);
    await authInterceptor.interceptResponse(data: responseData);

    expect(await tokenRepository.getToken(), null);

    await tokenRepository.setToken('abbc');
    expect(await tokenRepository.getToken(), 'abbc');

    when(mockRequest.url).thenReturn(Uri.parse('http://localhost'));
    when(mockResponse.request).thenReturn(mockRequest);
    when(mockResponse.statusCode).thenReturn(403);

    responseData = ResponseData.fromHttpResponse(mockResponse);
    await authInterceptor.interceptResponse(data: responseData);

    expect(await tokenRepository.getToken(), null);
  });
}

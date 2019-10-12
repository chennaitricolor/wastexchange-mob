import 'package:test/test.dart';
import 'package:wastexchange_mobile/models/http_request.dart';

void main() {
  test('init when method is null throws exception', () {
    expect(
        () =>
            HttpRequest(method: null, isAuthenticated: true, url: '/v1/users'),
        throwsA(const TypeMatcher<AssertionError>()));
  });

  test('init when url is null throws exception', () {
    expect(
        () => HttpRequest(
            method: HttpMethod.GET, isAuthenticated: true, url: null),
        throwsA(const TypeMatcher<AssertionError>()));
  });

  test('init when isAuthenticated is null throws exception', () {
    expect(
        () => HttpRequest(
            method: HttpMethod.GET, isAuthenticated: null, url: '/v1/users'),
        throwsA(const TypeMatcher<AssertionError>()));
  });

  test('init when shouldRetryOn401 is null throws exception', () {
    expect(
        () => HttpRequest(
            method: HttpMethod.GET,
            isAuthenticated: true,
            url: '/v1/users',
            shouldRetryOn401: null),
        throwsA(const TypeMatcher<AssertionError>()));
  });

  test('init assigns {} to headers when headers argument is null', () {
    final HttpRequest request = HttpRequest(
        method: HttpMethod.GET, isAuthenticated: true, url: '/v1/users');
    expect(request.headers, <String, String>{});
  });
}

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/resources/cached_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockStorage extends Mock implements FlutterSecureStorage {}

///Test case to check reading and writing flutter secure storage.
void main() {
  TokenRepository tokenRepository;
  String token;

  setUp(() {
    tokenRepository =
        TokenRepository.testInit(CachedSecureStorage(MockStorage()));
  });

  test('Setting jwt token THEN expect it to retrieve the same', () async {
    const sampleJwtToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

    token = sampleJwtToken;

    await tokenRepository.setToken(sampleJwtToken);

    expect(await tokenRepository.getToken(), sampleJwtToken);
  });

  test(
      'Setting jwt token in multiple futures THEN expect it to retrieve the same in order',
      () async {
    const sampleJwtToken1 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkxIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.gCtyCNK1GbhBXIG_gIlb8HpB5xl4_wlivgly0yN3na8';
    const sampleJwtToken2 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkyIiwibmFtZSI6IlBSYXNhbm5hIERvZSIsImlhdCI6MTUxNjIzOTAyMn0.wS0stFzGkhygpmnzZoWMPTUjkDzA_dFi7aSVFZhqIjg';
    const sampleJwtToken3 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkzIiwibmFtZSI6IlNhbXRobyBEb2UiLCJpYXQiOjE1MTYyMzkwMjJ9.lCvAuq_71AHlb-dtgATQpxG3_TJAlVaoHXKpJd-tQ14';

    token = sampleJwtToken1;

    tokenRepository.setToken(token);
    final String retrieved1 = await tokenRepository.getToken();

    token = sampleJwtToken2;
    tokenRepository.setToken(token);
    final String retrieved2 = await tokenRepository.getToken();

    token = sampleJwtToken3;
    tokenRepository.setToken(token);
    final String retrieved3 = await tokenRepository.getToken();

    expect(retrieved1, sampleJwtToken1);
    expect(retrieved2, sampleJwtToken2);
    expect(retrieved3, sampleJwtToken3);
  });

  test('CHECK isAuthorized() method returns positive WHEN token is present',
      () async {
    const sampleJwtToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkxIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.gCtyCNK1GbhBXIG_gIlb8HpB5xl4_wlivgly0yN3na8';

    token = sampleJwtToken;
    await tokenRepository.setToken(token);

    expect(tokenRepository.isAuthorized(), true);
  });

  test(
      'CHECK delete() method clears token and VERIFY isAuthorized() returns false',
      () async {
    await tokenRepository.deleteToken();

    expect(tokenRepository.isAuthorized(), false);
  });
}

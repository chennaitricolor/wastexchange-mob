import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/utils/cached_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockStorage extends Mock implements FlutterSecureStorage {}

///Test case to check reading and writing flutter secure storage.
void main() {
  TokenRepository tokenRepository;
  String token;

  setUp(() {
    tokenRepository = TokenRepository(CachedSecureStorage(MockStorage()));
  });

  test('Setting jwt token THEN expect it to retrieve the same', () async {
    const SAMPLE_JWT_TOKEN_TO_WRITE =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

    token = SAMPLE_JWT_TOKEN_TO_WRITE;

    await tokenRepository.setToken(SAMPLE_JWT_TOKEN_TO_WRITE);

    expect(await tokenRepository.getToken(), SAMPLE_JWT_TOKEN_TO_WRITE);
  });

  test(
      'Setting jwt token in multiple futures THEN expect it to retrieve the same in order',
      () async {
    const SAMPLE_JWT_TOKEN_TO_WRITE1 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkxIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.gCtyCNK1GbhBXIG_gIlb8HpB5xl4_wlivgly0yN3na8';
    const SAMPLE_JWT_TOKEN_TO_WRITE2 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkyIiwibmFtZSI6IlBSYXNhbm5hIERvZSIsImlhdCI6MTUxNjIzOTAyMn0.wS0stFzGkhygpmnzZoWMPTUjkDzA_dFi7aSVFZhqIjg';
    const SAMPLE_JWT_TOKEN_TO_WRITE3 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkzIiwibmFtZSI6IlNhbXRobyBEb2UiLCJpYXQiOjE1MTYyMzkwMjJ9.lCvAuq_71AHlb-dtgATQpxG3_TJAlVaoHXKpJd-tQ14';

    token = SAMPLE_JWT_TOKEN_TO_WRITE1;

    tokenRepository.setToken(token);
    final String retrieved1 = await tokenRepository.getToken();

    token = SAMPLE_JWT_TOKEN_TO_WRITE2;
    tokenRepository.setToken(token);
    final String retrieved2 = await tokenRepository.getToken();

    token = SAMPLE_JWT_TOKEN_TO_WRITE3;
    tokenRepository.setToken(token);
    final String retrieved3 = await tokenRepository.getToken();

    expect(retrieved1, SAMPLE_JWT_TOKEN_TO_WRITE1);
    expect(retrieved2, SAMPLE_JWT_TOKEN_TO_WRITE2);
    expect(retrieved3, SAMPLE_JWT_TOKEN_TO_WRITE3);
  });

  test('CHECK isAuthorized() method returns positive WHEN token is present',
      () async {
    const SAMPLE_JWT_TOKEN =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkxIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.gCtyCNK1GbhBXIG_gIlb8HpB5xl4_wlivgly0yN3na8';

    token = SAMPLE_JWT_TOKEN;

    expect(tokenRepository.isAuthorized(), true);
  });

  test(
      'CHECK delete() method clears token and VERIFY isAuthorized() returns false',
      () async {
    await tokenRepository.deleteToken();

    expect(tokenRepository.isAuthorized(), false);
  });
}


import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wastexchange_mobile/util/cached_secure_storage.dart';

class MockStorage extends Mock implements FlutterSecureStorage {

}

///Test case to check reading and writing flutter secure storage.
void main() {

  test('Setting jwt token', () async {
    const SAMPLE_JWT_TOKEN_TO_WRITE = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

    final mockStorage = MockStorage();
    when(await mockStorage.read(key: 'access_token')).thenReturn(SAMPLE_JWT_TOKEN_TO_WRITE);

    //Setting the mock storage to our component to stimulate it.
    CachedSecureStorage(mockStorage);

    final authRepository = TokenRepository();

    await authRepository.setToken(SAMPLE_JWT_TOKEN_TO_WRITE);

    final String retrieved = await authRepository.getToken();

    expect(retrieved, SAMPLE_JWT_TOKEN_TO_WRITE);
  });


  test('Setting jwt token in multiple futures', () async {
    const SAMPLE_JWT_TOKEN_TO_WRITE1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkxIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.gCtyCNK1GbhBXIG_gIlb8HpB5xl4_wlivgly0yN3na8';
    const SAMPLE_JWT_TOKEN_TO_WRITE2 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkyIiwibmFtZSI6IlBSYXNhbm5hIERvZSIsImlhdCI6MTUxNjIzOTAyMn0.wS0stFzGkhygpmnzZoWMPTUjkDzA_dFi7aSVFZhqIjg';
    const SAMPLE_JWT_TOKEN_TO_WRITE3 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkzIiwibmFtZSI6IlNhbXRobyBEb2UiLCJpYXQiOjE1MTYyMzkwMjJ9.lCvAuq_71AHlb-dtgATQpxG3_TJAlVaoHXKpJd-tQ14';

    final mockStorage = MockStorage();
    CachedSecureStorage(mockStorage);

    final authRepository = TokenRepository();

    authRepository.setToken(SAMPLE_JWT_TOKEN_TO_WRITE1);
    when(await mockStorage.read(key: 'access_token')).thenReturn(SAMPLE_JWT_TOKEN_TO_WRITE1);
    final String retrieved1 = await authRepository.getToken();

    authRepository.setToken(SAMPLE_JWT_TOKEN_TO_WRITE2);
    when(await mockStorage.read(key: 'access_token')).thenReturn(SAMPLE_JWT_TOKEN_TO_WRITE2);
    final String retrieved2 = await authRepository.getToken();

    authRepository.setToken(SAMPLE_JWT_TOKEN_TO_WRITE3);
    when(await mockStorage.read(key: 'access_token')).thenReturn(SAMPLE_JWT_TOKEN_TO_WRITE3);
    final String retrieved3 = await authRepository.getToken();

    expect(retrieved1, SAMPLE_JWT_TOKEN_TO_WRITE1);
    expect(retrieved2, SAMPLE_JWT_TOKEN_TO_WRITE2);
    expect(retrieved3, SAMPLE_JWT_TOKEN_TO_WRITE3);
  });
}

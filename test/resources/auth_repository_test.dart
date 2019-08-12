
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/resources/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockStorage extends Mock implements FlutterSecureStorage {

}

///Test case to check reading and writing flutter secure storage.
void main() {

  test('Setting access token', () async {
    const SAMPLE_ACCESS_TOKEN_TO_WRITE = 'eyJz93akdixdfcek4laUWw';

    final mockStorage = MockStorage();
    when(await mockStorage.read(key: 'access_token')).thenReturn(SAMPLE_ACCESS_TOKEN_TO_WRITE);

    final authRepository = AuthRepository(MockStorage());

    await authRepository.setAccessToken(SAMPLE_ACCESS_TOKEN_TO_WRITE);

    String retrieved = await authRepository.getAccessToken();

    expect(retrieved, SAMPLE_ACCESS_TOKEN_TO_WRITE);
  });


  test('Setting access token in multiple futures', () async {
    const SAMPLE_ACCESS_TOKEN_TO_WRITE1 = '1111111111111111111111';
    const SAMPLE_ACCESS_TOKEN_TO_WRITE2 = '2222222222222222222222';
    const SAMPLE_ACCESS_TOKEN_TO_WRITE3 = '3333333333333333333333';

    final authRepository = AuthRepository(MockStorage());

    authRepository.setAccessToken(SAMPLE_ACCESS_TOKEN_TO_WRITE1);
    String retrieved1 = await authRepository.getAccessToken();

    authRepository.setAccessToken(SAMPLE_ACCESS_TOKEN_TO_WRITE2);
    String retrieved2 = await authRepository.getAccessToken();

    authRepository.setAccessToken(SAMPLE_ACCESS_TOKEN_TO_WRITE3);
    String retrieved3 = await authRepository.getAccessToken();

    expect(retrieved1, SAMPLE_ACCESS_TOKEN_TO_WRITE1);
    expect(retrieved2, SAMPLE_ACCESS_TOKEN_TO_WRITE2);
    expect(retrieved3, SAMPLE_ACCESS_TOKEN_TO_WRITE3);
  });
}

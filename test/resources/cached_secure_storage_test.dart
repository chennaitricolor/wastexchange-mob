import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wastexchange_mobile/util/cached_secure_storage.dart';

class MockFlutterStorage extends Mock implements FlutterSecureStorage {}

void main() {

  CachedSecureStorage cachedSecureStorage;

  setUp(() {
    cachedSecureStorage = CachedSecureStorage(MockFlutterStorage());
  });

  test('check Storage Stores value based on the distinct KEY provided', () async {

    cachedSecureStorage.setValue('access_token', 'xdfcceee');
    cachedSecureStorage.setValue('jwt_token', 'abcdeee');

    expect(await cachedSecureStorage.getValue('access_token'), 'xdfcceee');
    expect(await cachedSecureStorage.getValue('jwt_token'), 'abcdeee');
  });
}

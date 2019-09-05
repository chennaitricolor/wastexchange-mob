import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/cached_secure_storage.dart';

class MockUserClient extends Mock implements UserClient {}

class MockTokenRepository extends Mock implements TokenRepository {}

class MockCachedSecureStorage extends Mock implements CachedSecureStorage {}

///Test case to check reading and writing flutter secure storage.
void main() {
  MockUserClient mockUserClient;
  MockTokenRepository mockTokenRepository;
  MockCachedSecureStorage mockCachedSecureStorage;
  UserRepository userRepository;

  const email = 'email';
  const mobile = 'mobile';
  const city = 'city';
  const persona = 'persona';
  const long = 14.5;
  const password = '123445';
  const lat = 10.2;
  const mobileNumber = 9988776655;
  const altMobileNumber = 0;
  const name = 'name';
  const address = 'address';
  const pincode = 60000;
  const otp = 123456;

  setUp(() {
    mockUserClient = MockUserClient();
    mockTokenRepository = MockTokenRepository();
    mockCachedSecureStorage = MockCachedSecureStorage();
    userRepository = UserRepository(
        client: mockUserClient,
        tokenRepository: mockTokenRepository,
        secureStorage: mockCachedSecureStorage);
  });

  test('GIVEN otp data CHECK send otp is called from client', () async {
    final otpData = OtpData(emailId: email, mobileNo: mobile);
    userRepository.sendOTP(otpData);

    final OtpData capturedData =
        verify(mockUserClient.sendOTP(captureAny)).captured.single;
    expect(capturedData.emailId, email);
    expect(capturedData.mobileNo, mobile);
  });

  test('GIVEN registration data CHECK register is called from client',
      () async {
    final registrationData = RegistrationData(
        city: city,
        emailId: email,
        persona: persona,
        long: long,
        lat: lat,
        password: password,
        altMobNo: altMobileNumber,
        name: name,
        address: address,
        mobNo: mobileNumber,
        pinCode: pincode,
        otp: otp);

    mockUserClient.register(registrationData);
    final RegistrationData capturedData =
        verify(mockUserClient.register(captureAny)).captured.single;

    expect(capturedData.city, city);
    expect(capturedData.emailId, email);
    expect(capturedData.persona, persona);
    expect(capturedData.long, long);
    expect(capturedData.lat, lat);
    expect(capturedData.password, password);
    expect(capturedData.altMobNo, altMobileNumber);
    expect(capturedData.name, name);
    expect(capturedData.address, address);
    expect(capturedData.mobNo, mobileNumber);
    expect(capturedData.pinCode, pincode);
    expect(capturedData.otp, otp);
  });

  test('GIVEN login data THEN set token should be called', () async {
    final loginData = LoginData(loginId: email, password: password);

    final expectedResponse =
        LoginResponse(auth: true, token: 'token_id', approved: true);

    when(mockUserClient.login(loginData))
        .thenAnswer((_) async => Result.completed(expectedResponse));
    when(mockUserClient.myProfile())
        .thenAnswer((_) async => Result.completed(User()));

    userRepository.login(loginData).then((loginResponse) {
      final String capturedData =
          verify(mockTokenRepository.setToken(captureAny)).captured.single;
      expect(capturedData, 'token_id');
      expect(loginResponse, const TypeMatcher<Result<LoginResponse>>());
    });
  });

  test('GIVEN login data THEN set token should not be called', () async {
    final loginData = LoginData(loginId: email, password: password);

    when(mockUserClient.login(loginData))
        .thenAnswer((_) async => Result.error('error'));

    userRepository.login(loginData).then((loginResponse) {
      verifyNever(mockTokenRepository.setToken(any));
      expect(loginResponse, const TypeMatcher<Result<LoginResponse>>());
    });
  });

  test('SHOULD check get all users are called from client only once', () async {
    userRepository.getAllUsers();
    verify(mockUserClient.getAllUsers()).called(1);
  });
}

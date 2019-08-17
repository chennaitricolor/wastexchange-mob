import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';

class MockUserClient extends Mock implements UserClient {}

class MockTokenRepository extends Mock implements TokenRepository {}

///Test case to check reading and writing flutter secure storage.
void main() {
  MockUserClient userClient;
  MockTokenRepository tokenRepository;
  UserRepository userRepository;

  setUp(() {
    userClient = MockUserClient();
    tokenRepository = MockTokenRepository();
    userRepository =
        UserRepository(client: userClient, tokenRepository: tokenRepository);
  });

  test(
      'GIVEN otp data WHEN email and mobile number are valid THEN receive success response',
      () async {
    const message = 'OTP has been sent successfully';
    final otpData = OtpData(emailId: 'email', mobileNo: 'mobile');
    when(userClient.sendOTP(otpData))
        .thenAnswer((_) async => OtpResponse(message: message));
    userRepository.sendOTP(otpData).then((data) {
      expect(data.message, message);
    });
  });

  test(
      'GIVEN registration data WHEN all the fields are valid THEN receive success response',
      () async {
    const message = 'registration message';
    final registrationData = RegistrationData(
        city: 'city',
        emailId: 'email',
        persona: 'persona',
        long: 14.5,
        lat: 10.2,
        password: '123445',
        altMobNo: 0,
        name: 'name',
        address: 'address',
        mobNo: 9988776655,
        pinCode: 123456,
        otp: 232345);

    when(userClient.register(registrationData)).thenAnswer((_) async =>
        RegistrationResponse(
            message: message, success: true, auth: true, token: 'token_id'));
    userRepository.register(registrationData).then((data) {
      expect(data.message, message);
      expect(data.success, true);
      expect(data.auth, true);
      expect(data.token, 'token_id');
    });
  });

  test(
      'GIVEN login data WHEN email and password are valid THEN receive success response',
      () async {
    final loginData = LoginData(loginId: 'email', password: '123445');

    when(userClient.login(loginData)).thenAnswer((_) async =>
        Result.completed(LoginResponse(auth: true, token: 'token_id')));
    userRepository.login(loginData).then((result) {
      expect(result.data.auth, true);
      expect(result.data.token, 'token_id');
    });
  });

  test('GET all users THEN receive success response', () async {
    const mobileNumber = '9988776655';
    const latitude = 10.34;
    const longitude = 14.98;

    when(userClient.getAllUsers()).thenAnswer((_) async => [
          User(
              id: 1,
              pinCode: 123456,
              mobNo: mobileNumber,
              address: 'address',
              name: 'name',
              altMobNo: mobileNumber,
              lat: latitude,
              long: longitude,
              persona: 'seller',
              emailId: 'email',
              city: 'city',
              approved: true)
        ]);
    userRepository.getAllUsers().then((data) {
      expect(data.length, 1);
      final User user = data[0];
      expect(user.mobNo, mobileNumber);
      expect(user.lat, latitude);
      expect(user.long, longitude);
    });
  });
}

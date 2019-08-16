import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/user.dart';


class MockApiHelper extends Mock implements ApiBaseHelper {}

void main() {

  group('login', () {

    test('throws an exception if the http call completes with an error', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      when(mockApiHelper.post(false, UserClient.PATH_LOGIN, LoginData(loginId: 'a', password: 'b').toMap())).thenThrow(ApiException());

      final UserClient provider = UserClient(mockApiHelper);

      expect(provider.login(LoginData(loginId: 'a', password: 'b')), throwsA(const TypeMatcher<ApiException>()));
    });

    test('returns a LoginResponse if the http call completes successfully', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      when(mockApiHelper.post(false, UserClient.PATH_LOGIN, LoginData(loginId: 'a', password: 'b').toMap())).thenAnswer(
          (_) async => '{"auth":true,"token":"token"}');

      final UserClient provider = UserClient(mockApiHelper);
      final result = await provider.login(LoginData(loginId: 'a', password: 'b'));

      expect(result, const TypeMatcher<LoginResponse>());
      expect(result.auth, true);
      expect(result.token, 'token');
    });
  });

  group('register', () {

    test('returns a RegistrationResponse if the http call completes successfully', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      final registrationData = RegistrationData(name: 'Pearson', address: 'taramani', emailId: 'guest@wasteexchange.com', mobNo: 9998887777, altMobNo: 8887776666, otp: 1234, lat: 80.1245, long: 22.1789, pinCode: 60000,city: 'Chennai', password: 'b');

      when(mockApiHelper.post(false, UserClient.PATH_REGISTER, registrationData.toJson())).thenAnswer(
              (_) async => '{"success":true, "message":"registration success","auth":true,"token":"token"}');

      final UserClient provider = UserClient(mockApiHelper);
      final result = await provider.register(registrationData);

      expect(result, const TypeMatcher<RegistrationResponse>());
      expect(result.auth, true);
      expect(result.token, 'token');
      expect(result.success, true);
    });
  });

  group('otp', () {

    test('returns a OtpResponse if the http call completes successfully', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      final otpData = OtpData(emailId: 'guest@wastexchange.com', mobileNo: '9998887777');

      when(mockApiHelper.post(false, UserClient.PATH_SEND_OTP, otpData.toMap())).thenAnswer(
              (_) async => '{"message":"OTP Sent"}');

      final UserClient provider = UserClient(mockApiHelper);
      final result = await provider.sendOTP(otpData);

      expect(result, const TypeMatcher<OtpResponse>());
      expect(result.message, 'OTP Sent');
    });
  });

  group('getAllUsers', () {

    test('returns List<User> if the http call completes successfully', () async {
      final MockApiHelper mockApiHelper = MockApiHelper();

      when(mockApiHelper.get(false, UserClient.PATH_USERS)).thenAnswer(
              (_) async => '[{"id":1,"city":"Chennai","pinCode":600100,"persona":null,"address":"Taramani","mobNo":"9998887777","altMobNo":"8887776666","lat":12.8,"long":80.24,"emailId":"guest@wastexchange.com","name":"Pearson","approved":true}]');

      final UserClient provider = UserClient(mockApiHelper);
      final result = await provider.getAllUsers();

      expect(result, const TypeMatcher<List<User>>());
      expect(result.length, 1);
      expect(result[0].id, 1);
      expect(result[0].name, 'Pearson');
      expect(result[0].approved, true);
      expect(result[0].mobNo, '9998887777');
      expect(result[0].altMobNo, '8887776666');
      expect(result[0].persona, null);
      expect(result[0].city, 'Chennai');
      expect(result[0].address, 'Taramani');
      expect(result[0].emailId, 'guest@wastexchange.com');
      expect(result[0].pinCode, 600100);
    });
  });
}

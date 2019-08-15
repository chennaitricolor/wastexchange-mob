import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';

class UserRepository {

  UserRepository({UserClient client, TokenRepository tokenRepository})  {
    _client = client ?? UserClient();
    _tokenRepository = tokenRepository ?? TokenRepository();
  }

  UserClient _client;
  TokenRepository _tokenRepository;

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    return await _client.sendOTP(otpData);
  }

  Future<RegistrationResponse> register(RegistrationData registrationData) async {
    return await _client.register(registrationData);
  }

  Future<LoginResponse> login(LoginData loginData) async {
    LoginResponse response = await _client.login(loginData);

    //Set response to TokenRepository to persist access token information and wait for completeness.
    await _tokenRepository.setToken(response.token);

    return Future.value(response);
  }

  Future<List<User>> getAllUsers() async {
    return await _client.getAllUsers();
  }
}

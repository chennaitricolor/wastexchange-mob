import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/models/result.dart';

class UserRepository {
  UserRepository({UserClient client, TokenRepository tokenRepository}) {
    _client = client ?? UserClient();
    _tokenRepository = tokenRepository ?? TokenRepository();
  }

  UserClient _client;
  TokenRepository _tokenRepository;

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    return await _client.sendOTP(otpData);
  }

  Future<RegistrationResponse> register(
      RegistrationData registrationData) async {
    return await _client.register(registrationData);
  }

  Future<Result<LoginResponse>> login(LoginData loginData) async {
    final Result<LoginResponse> response = await _client.login(loginData);

    if (response.status == Status.COMPLETED) {
      //Set response to TokenRepository to persist access token information and wait for completeness.
      await _tokenRepository.setToken(response.data.token);
    }

    return response;
  }

  Future<List<User>> getAllUsers() async {
    return await _client.getAllUsers();
  }

  Future<SellerItemDetails> getSellerDetails(int id) async {
    return await _client.getSellerDetails(id);
  }
}

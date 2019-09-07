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
import 'package:wastexchange_mobile/utils/cached_secure_storage.dart';

class UserRepository {
  UserRepository(
      {UserClient client,
      TokenRepository tokenRepository,
      CachedSecureStorage secureStorage}) {
    _client = client ?? UserClient();
    _tokenRepository = tokenRepository ?? TokenRepository();
    _secureStorage = secureStorage ?? CachedSecureStorage();
  }

  UserClient _client;
  TokenRepository _tokenRepository;
  CachedSecureStorage _secureStorage;

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    return await _client.sendOTP(otpData);
  }

  Future<RegistrationResponse> register(
      RegistrationData registrationData) async {
    return await _client.register(registrationData);
  }

  Future<Result<LoginResponse>> login(LoginData loginData) async {
    final Result<LoginResponse> loginResponse = await _client.login(loginData);

    if (loginResponse.status == Status.COMPLETED) {
      await _tokenRepository.setToken(loginResponse.data.token);
      final Result<User> userResponse = await _getProfileFromNetwork();
      if (userResponse.status != Status.COMPLETED) {
        _tokenRepository.deleteToken();
      }
      loginResponse.status = userResponse.status;
    }

    return loginResponse;
  }

  Future<List<User>> getAllUsers() async {
    return await _client.getAllUsers();
  }

  Future<Result<SellerItemDetails>> getSellerDetails(int sellerId) async {
    return await _client.getSellerDetails(sellerId);
  }

  Future<String> getProfileId() async {
    return _secureStorage.getValue('id');
  }

  Future<Result<User>> _getProfileFromNetwork() async {
    final Result<User> userResponse = await _client.myProfile();
    if (userResponse.status == Status.COMPLETED) {
      _saveProfile(userResponse.data);
    }
    return userResponse;
  }

  void _saveProfile(User user) {
    user.toJson().forEach((k, v) => _secureStorage.setValue(k, v.toString()));
  }
}

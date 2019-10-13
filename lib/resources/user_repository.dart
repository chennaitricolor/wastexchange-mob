import 'package:wastexchange_mobile/launch_setup.dart';
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
import 'package:wastexchange_mobile/resources/user_data_store.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class UserRepository implements LaunchSetupMember {
  UserRepository(
      {UserClient client,
      TokenRepository tokenRepository,
      UserDataStore userDataStore}) {
    _client = client ?? UserClient();
    _tokenRepository = tokenRepository ?? TokenRepository();
    _userDataStore = userDataStore ?? UserDataStore();
  }

  UserClient _client;
  TokenRepository _tokenRepository;
  UserDataStore _userDataStore;

  Future<Result<OtpResponse>> sendOTP(OtpData otpData) async {
    return await _client.sendOTP(otpData);
  }

  Future<Result<RegistrationResponse>> register(
      RegistrationData registrationData) async {
    return await _client.register(registrationData);
  }

  Future<Result<LoginResponse>> login(LoginData loginData) async {
    final Result<LoginResponse> loginResponse = await _client.login(loginData);
// TODO(Sayeed): Can we improve this. Examining the state and doing computations here feels off.
    if (loginResponse.status == Status.COMPLETED) {
      await _tokenRepository.setToken(loginResponse.data.token);
      final Result<User> userResponse = await _client.myProfile();
      if (userResponse.status == Status.COMPLETED) {
        _userDataStore.saveProfile(userResponse.data);
      } else {
        _tokenRepository.deleteToken();
      }
      loginResponse.status = userResponse.status;
    }

    return loginResponse;
  }

  Future<Result<List<User>>> getAllUsers() async {
    final Result<List<User>> allUsersResponse = await _client.getAllUsers();
// TODO(Sayeed): Can we improve this. Examining the state and doing computations here feels off.
    if (allUsersResponse.status == Status.COMPLETED) {
      _userDataStore.saveUsers(allUsersResponse.data);
    }
    return allUsersResponse;
  }

  Future<Result<SellerItemDetails>> getSellerDetails(int sellerId) async {
    return await _client.getSellerDetails(sellerId);
  }

  Future<User> getProfile() async {
    return _userDataStore.getProfile();
  }

  Future<Result<User>> getUser({int id, bool forceNetwork = false}) async {
    final User user = _userDataStore.getUser(id: id);
    if (isNotNull(user)) {
      return Result.completed(user);
    }
    return _client.getUser(id: id);
  }

  @override
  Future<void> load() async {
    await UserDataStore().getProfile();
  }

  void logoutUser() {
    _tokenRepository.deleteToken();
    _userDataStore.deleteUser();
  }
}

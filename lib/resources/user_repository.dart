import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';

class UserRepository {
  final UserClient _client = UserClient();

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    return await _client.sendOTP(otpData);
  }

  Future<LoginResponse> login(LoginData loginData) async {
    return await _client.login(loginData);
  }

  Future<List<User>> getAllUsers() async {
    return await _client.getAllUsers();
  }
}

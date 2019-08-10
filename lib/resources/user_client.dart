import 'package:wastexchange_mobile/models/auth_info.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class UserClient {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<LoginResponse> login(LoginData loginData) async {
    final String response = await _apiBaseHelper.post(
        ApiBaseHelper.baseApiUrl + Constants.PATH_LOGIN, loginData.toMap());
    final loginResponse = loginResponseFromJson(response);
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }

  Future<RegistrationResponse> register(RegistrationData data) async {
    final String response = await _apiBaseHelper.post(
        ApiBaseHelper.baseApiUrl + Constants.PATH_REGISTER, data.toJson());
    final registrationResponse = registrationResponseFromJson(response);
    return registrationResponse;
  }

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    final String response = await _apiBaseHelper.post(
        ApiBaseHelper.baseApiUrl + Constants.PATH_SEND_OTP, otpData.toMap());
    final otpResponse = otpResponseFromJson(response);
    return otpResponse;
  }

  Future<List<User>> getAllUsers() async {
    final response =
        await _apiBaseHelper.get(ApiBaseHelper.baseApiUrl + Constants.PATH_USERS);
    return userFromJson(response);
  }
}

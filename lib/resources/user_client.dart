import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class UserClient {
  static const PATH_SEND_OTP = '/users/sendOtp';
  static const PATH_LOGIN = '/users/login';
  static const PATH_REGISTER = '/users/register';
  static const PATH_USERS = '/users';

  Future<LoginResponse> login(LoginData loginData) async {
    final String response = await ApiBaseHelper.getInstance(false).post(
        PATH_LOGIN, loginData.toMap());
    final loginResponse = loginResponseFromJson(response);
    return loginResponse;
  }

  Future<RegistrationResponse> register(RegistrationData data) async {
    final String response = await ApiBaseHelper.getInstance(false).post(
        PATH_REGISTER, data.toJson());
    final registrationResponse = registrationResponseFromJson(response);
    return registrationResponse;
  }

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    final String response = await ApiBaseHelper.getInstance(false).post(
        PATH_SEND_OTP, otpData.toMap());
    final otpResponse = otpResponseFromJson(response);
    return otpResponse;
  }

  Future<List<User>> getAllUsers() async {
    final response =
        await ApiBaseHelper.getInstance(true).get(PATH_USERS);
    return userFromJson(response);
  }
}

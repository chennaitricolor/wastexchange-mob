import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/models/result.dart';

class UserClient {
  UserClient([ApiBaseHelper helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const PATH_SEND_OTP = '/users/sendOtp';
  static const PATH_LOGIN = '/users/login';
  static const PATH_REGISTER = '/users/register';
  static const PATH_USERS = '/users';

  ApiBaseHelper _helper;

  Future<Result<LoginResponse>> login(LoginData loginData) async {
    try {
      final String response =
          await _helper.post(false, PATH_LOGIN, loginData.toMap());
      final LoginResponse loginResponse = loginResponseFromJson(response);
      return Result.completed(loginResponse);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<RegistrationResponse> register(RegistrationData data) async {
    final String response =
        await _helper.post(false, PATH_REGISTER, data.toJson());
    final registrationResponse = registrationResponseFromJson(response);
    return registrationResponse;
  }

  Future<OtpResponse> sendOTP(OtpData otpData) async {
    final String response =
        await _helper.post(false, PATH_SEND_OTP, otpData.toMap());
    final otpResponse = otpResponseFromJson(response);
    return otpResponse;
  }

  Future<List<User>> getAllUsers() async {
    final response = await _helper.get(false, PATH_USERS);
    return userFromJson(response);
  }

  Future<SellerItemDetails> getSellerDetails(int id) async {
    final pathSellerItems = '/seller/$id/items';
    final response = await _helper.get(false, pathSellerItems);
    return SellerItemDetails.fromJson(response);
  }
}

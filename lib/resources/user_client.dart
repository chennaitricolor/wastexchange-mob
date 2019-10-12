import 'dart:convert';
import 'package:wastexchange_mobile/models/app_error.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/models/result_v2.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/http_request_manager.dart';
import 'package:wastexchange_mobile/resources/json_parsing.dart';
import 'package:wastexchange_mobile/resources/user_client_http_requests.dart';

class UserClient {
  UserClient(
      [ApiBaseHelper helper,
      HttpRequestManager manager,
      JsonCodec json,
      UserClientHttpRequests clientHttpRequests]) {
    _helper = helper ?? ApiBaseHelper();
    _manager = manager ?? HttpRequestManagerImpl();
    _json = json ?? const JsonCodec();
    _clientHttpRequests = clientHttpRequests ?? UserClientHttpRequests();
  }

  static const PATH_SEND_OTP = '/users/sendOtp';
  static const PATH_LOGIN = '/users/login';
  static const PATH_REGISTER = '/users/register';
  static const PATH_USERS = '/users';
  static const PATH_ME = '/users/me';
  static const PATH_SELLER_ITEMS = '/seller/:sellerId/items';
  static const PATH_USER_DETAILS = '/users/:id';

  ApiBaseHelper _helper;
  HttpRequestManager _manager;
  JsonCodec _json;
  UserClientHttpRequests _clientHttpRequests;

  Future<ResultV2<LoginResponse, AppError>> login(LoginData data) async {
    final request = _clientHttpRequests.loginRequest(data);
    final response = await _manager.performRequest(request);
    if (response.hasError) {
      return ResultV2.error(response.error);
    }
    try {
      final loginResponse = LoginResponse.fromJson(_json.decode(response.data));
      return ResultV2.data(loginResponse);
    } catch (e) {
      return ResultV2.error(JsonParseError(e.toString()));
    }
  }

  // TODO(Sayeed): Change this to Future<Result<RegistrationResponse>>
  Future<RegistrationResponse> register(RegistrationData data) async {
    final String response =
        await _helper.post(false, PATH_REGISTER, data.toJson());
    final registrationResponse = registrationResponseFromJson(response);
    return registrationResponse;
  }

  // TODO(Sayeed): Change this to Future<Result<OtpResponse>>
  Future<OtpResponse> sendOTP(OtpData otpData) async {
    final String response =
        await _helper.post(false, PATH_SEND_OTP, otpData.toMap());
    final otpResponse = otpResponseFromJson(response);
    return otpResponse;
  }

  Future<Result<List<User>>> getAllUsers() async {
    try {
      final response = await _helper.get(PATH_USERS, authenticated: false);
      final List<User> users = userFromJson(json.decode(response));
      return Result.completed(users);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<SellerItemDetails>> getSellerDetails(int sellerId) async {
    final pathSellerItems =
        PATH_SELLER_ITEMS.replaceFirst(':sellerId', sellerId.toString());
    try {
      final response = await _helper.get(pathSellerItems, authenticated: false);
      final SellerItemDetails details = SellerItemDetails.fromJson(
          codecForIntToDoubleConversion(key: 'quantity').decode(response));
      return Result.completed(details);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<User>> myProfile() async {
    try {
      final String response = await _helper.get(PATH_ME);
      final User user = User.fromJson(json.decode(response));
      return Result.completed(user);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<User>> getUser({int id}) async {
    try {
      final response =
          await _helper.get(PATH_USERS.replaceFirst(':id', id.toString()));
      final User user = User.fromJson(json.decode(response));
      return Result.completed(user);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}

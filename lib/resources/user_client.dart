import 'dart:convert';
import 'package:wastexchange_mobile/models/api_exception.dart';
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
import 'package:wastexchange_mobile/resources/json_parsing.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';

class UserClient {
  UserClient([ApiBaseHelper helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const pathSendOtp = '/users/sendOtp';
  static const pathLogin = '/users/login';
  static const pathRegister = '/users/register';
  static const pathUsers = '/users';
  static const pathMe = '/users/me';
  static const pathSellerItems = '/seller/:sellerId/items';
  static const pathUserDetails = '/users/:id';

  ApiBaseHelper _helper;

  Future<Result<LoginResponse>> login(LoginData loginData) async {
    try {
      final String response =
          await _helper.post(false, pathLogin, loginData.toMap());
      final LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(response));
      return Result.completed(loginResponse);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(LocaleConstants.LOGIN_FAILED);
    }
  }

  Future<Result<RegistrationResponse>> register(RegistrationData data) async {
    try {
      final String response =
          await _helper.post(false, pathRegister, data.toJson());
      final registrationResponse =
          RegistrationResponse.fromJson(json.decode(response));
      return Result.completed(registrationResponse);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.REGISTRATION_FAILED);
    }
  }

  Future<Result<OtpResponse>> sendOTP(OtpData otpData) async {
    try {
      final String response =
          await _helper.post(false, pathSendOtp, otpData.toMap());
      final otpResponse = OtpResponse.fromJson(json.decode(response));
      return Result.completed(otpResponse);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.SEND_OTP_FAIL);
    }
  }

  Future<Result<List<User>>> getAllUsers() async {
    try {
      final response = await _helper.get(pathUsers, authenticated: false);
      final List<User> users = userFromJson(json.decode(response));
      return Result.completed(users);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.MAP_LOADING_FAILED);
    }
  }

  Future<Result<SellerItemDetails>> getSellerDetails(int sellerId) async {
    final sellerItemsUrlPath =
        pathSellerItems.replaceFirst(':sellerId', sellerId.toString());
    try {
      final response = await _helper.get(sellerItemsUrlPath, authenticated: false);
      final SellerItemDetails details = SellerItemDetails.fromJson(
          codecForIntToDoubleConversion(key: 'quantity').decode(response));
      return Result.completed(details);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.SELLER_DETAILS_FETCH_FAILED);
    }
  }

  Future<Result<User>> getUser({int id}) async {
    try {
      final response =
          await _helper.get(pathUsers.replaceFirst(':id', id.toString()));
      final User user = User.fromJson(json.decode(response));
      return Result.completed(user);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.USER_FETCH_FAILED);
    }
  }

  Future<Result<User>> myProfile() async {
    try {
      final String response = await _helper.get(pathMe);
      final User user = User.fromJson(json.decode(response));
      return Result.completed(user);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.PROFILE_FETCH_FAILED);
    }
  }
}

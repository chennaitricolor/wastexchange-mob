import 'dart:convert';
import 'package:wastexchange_mobile/models/auth_info.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class UserClient {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<LoginResponse> login(LoginData loginData) async {
    final response = await _apiBaseHelper.post(
        'https://data.indiawasteexchange.com/users/login', loginData.toMap());
    final loginResponse = LoginResponse.fromJson(json.decode(response.body));
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }

  Future<List<User>> getAllUsers() async {
    final response =
        await _apiBaseHelper.get('http://data.indiawasteexchange.com/users');
    return User.fromJson(response.body);
  }
}

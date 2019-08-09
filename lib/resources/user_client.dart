import 'dart:convert';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class UserClient {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<LoginResponse> login(LoginData loginData) async {
    final response = await _apiBaseHelper.post(
        '${ApiBaseHelper.BASE_API_URL}/users/login', loginData.toMap());
    return LoginResponse.fromJson(json.decode(response.body));
  }

  Future<List<User>> getAllUsers() async {
    final response =
        await _apiBaseHelper.get('${ApiBaseHelper.BASE_API_URL}/users');
    return User.fromJson(response.body);
  }
}

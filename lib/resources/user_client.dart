import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/auth_info.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/util/http_utils.dart';

class UserClient {
  UserClient([Client client]) {
    _client = client ?? Client();
  }

  static const String BASE_URL = 'https://data.indiawasteexchange.com';
  Client _client;

  Future<LoginResponse> login(LoginData loginData) async {
    final response = await _client.post(
        '$BASE_URL/users/login',
        body: loginData.toMap());
    if (!HttpUtils.isSuccessfulResponse(response.statusCode)) {
      throw ApiResponseException('Failed to login, status code: ${response.statusCode}');
    }
    final loginResponse = LoginResponse.fromJson(json.decode(response.body));
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }

  Future<List<User>> getAllUsers() async {
    final response = await _client
        .get(
        '$BASE_URL/users',
        headers: {'accept': 'application/json'});
    if (!HttpUtils.isSuccessfulResponse(response.statusCode)) {
      throw ApiResponseException('failed to fetch users, status code: ${response.statusCode}');
    }
    return usersListFromJson(response.body);
  }
}

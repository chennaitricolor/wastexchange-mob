import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/auth_info.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/user.dart';

class UserClient {
  UserClient([Client client]) {
    _client = client ?? Client();
  }

  Client _client;

  Future<LoginResponse> login(LoginData loginData) async {
    final response = await _client.post(
        'https://data.indiawasteexchange.com/users/login',
        body: loginData.toMap());
    if (response.statusCode != 200) {
      throw ApiResponseException('invalid status code');
    }
    final loginResponse = LoginResponse.fromJson(json.decode(response.body));
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }

  Future<List<User>> getAllUsers() async {
    final response =
        await _client.get('http://data.indiawasteexchange.com/users');
    if (response.statusCode != 200) {
      throw Exception('failed to fetch users');
    }
    return User.fromJson(response.body);
  }
}

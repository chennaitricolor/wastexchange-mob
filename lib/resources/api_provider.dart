import 'package:http/http.dart' show Client;
import 'package:wastexchange_mobile/models/auth_info.dart';
import 'dart:convert';
import '../models/login_response.dart';
import 'package:wastexchange_mobile/common/constants.dart';

class ApiProvider {
  Client _client;

  ApiProvider([Client client]) {
    this._client = client == null ? Client() : client;
  }

  Future<LoginResponse> login(String loginId, String password) async {
    var map = new Map<String, String>();
    map['loginId'] = loginId;
    map['password'] = password;
    final response = await _client
        .post(userLoginUrl, body: map);
    if (response.statusCode != 200) {
      throw Exception('failed to login');
    }
    var loginResponse = LoginResponse.fromJson(json.decode(response.body));
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }
}

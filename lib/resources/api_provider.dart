import 'package:http/http.dart' show Client;
import 'package:wastexchange_mobile/models/auth_info.dart';
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'dart:convert';
import '../models/login_response.dart';

class ApiProvider {
  Client _client;

  ApiProvider([Client client]) {
    this._client = client == null ? Client() : client;
  }

  Future<LoginResponse> login(LoginData loginData) async {
    final response = await _client
        .post(Constants.URL_LOGIN, body: loginData.toMap());
    if (response.statusCode != 200) {
      throw ApiResponseException('invalid status code');
    }
    var loginResponse = LoginResponse.fromJson(json.decode(response.body));
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }
}

import 'package:http/http.dart' show Client;
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_request.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'dart:convert';
import '../models/login_response.dart';

class ApiProvider {
  Client _client;

  ApiProvider([Client client]) {
    this._client = client == null ? Client() : client;
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await _client
        .post(Constants.URL_LOGIN, body: loginRequest.toMap());
    if (response.statusCode != 200) {
      throw ApiResponseException('invalid status code');
    }
    return LoginResponse.fromJson(json.decode(response.body));
  }
}

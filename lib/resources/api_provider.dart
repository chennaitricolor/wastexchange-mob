import 'package:http/http.dart' show Client;
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'dart:convert';
import '../models/login_response.dart';

class ApiProvider {
  Client _client;

  ApiProvider([Client client]) {
    this._client = client == null ? Client() : client;
  }

  Future<LoginResponse> login(String loginId, String password) async {
    final body = {'loginId': loginId, 'password': password};
    final response = await _client
        .post('http://data.indiawasteexchange.com/users/login', body: body);
    if (response.statusCode != 200) {
      throw ApiResponseException('invalid status code');
    }
    return LoginResponse.fromJson(json.decode(response.body));
  }
}

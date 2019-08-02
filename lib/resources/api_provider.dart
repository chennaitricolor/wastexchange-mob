import 'package:http/http.dart' show Client;
<<<<<<< HEAD
import 'package:wastexchange_mobile/models/auth_info.dart';
=======
import 'package:wastexchange_mobile/models/api_response_exception.dart';
import 'package:wastexchange_mobile/models/login_request.dart';
import 'package:wastexchange_mobile/util/constants.dart';
>>>>>>> master
import 'dart:convert';
import '../models/login_response.dart';
import 'package:wastexchange_mobile/common/constants.dart';

class ApiProvider {
  Client _client;

  ApiProvider([Client client]) {
    this._client = client == null ? Client() : client;
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await _client
<<<<<<< HEAD
        .post(userLoginUrl, body: map);
=======
        .post(Constants.URL_LOGIN, body: loginRequest.toMap());
>>>>>>> master
    if (response.statusCode != 200) {
      throw ApiResponseException('invalid status code');
    }
    var loginResponse = LoginResponse.fromJson(json.decode(response.body));
    AuthInfo().authenticationToken = loginResponse.token;
    return loginResponse;
  }
}

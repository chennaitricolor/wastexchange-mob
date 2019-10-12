import 'dart:convert';

import 'package:wastexchange_mobile/models/http_request.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/resources/env_repository.dart';

class UserClientHttpRequests {
  UserClientHttpRequests({EnvRepository envRepository, JsonCodec json}) {
    final _envRepository = envRepository ?? EnvRepository();
    _baseApiUrl = _envRepository.baseApiURL();
    _json = json ?? const JsonCodec();
  }
  static const _pathLogin = '/users/login';
  String _baseApiUrl;
  JsonCodec _json;

  HttpRequest loginRequest(LoginData data) {
    return HttpRequest(
        method: HttpMethod.POST,
        url: _baseApiUrl + _pathLogin,
        isAuthenticated: true,
        shouldRetryOn401: false,
        body: _json.encode(data.toMap()),
        headers: {'Content-Type': 'application/json'});
  }
}

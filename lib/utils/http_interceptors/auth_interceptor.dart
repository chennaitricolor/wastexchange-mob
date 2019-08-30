import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

/// Interceptor that modify API Request by adding authentication information to the request.
class AuthInterceptor implements InterceptorContract {
  AuthInterceptor(TokenRepository tokenRepository) {
    _tokenRepository = tokenRepository;
  }

  TokenRepository _tokenRepository;

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    final String token = await _tokenRepository.getToken();
    if (token != null && data != null) {
      data.headers['x-access-token'] =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwicGVyc29uYSI6ImJ1eWVyIiwiaWF0IjoxNTY3MTg0MDc5LCJleHAiOjE1NjcyNzA0Nzl9.vKyup0x-Jt2oMAiDCAalpWz2XD6teg652NKkynX4bGQ';
    }
    data.headers['x-access-token'] =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwicGVyc29uYSI6ImJ1eWVyIiwiaWF0IjoxNTY3MTg0MDc5LCJleHAiOjE1NjcyNzA0Nzl9.vKyup0x-Jt2oMAiDCAalpWz2XD6teg652NKkynX4bGQ';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data != null && data.statusCode == Constants.UNAUTHORIZED ||
        data.statusCode == Constants.FORBIDDEN) {
      await _tokenRepository.deleteToken();
    }
    return data;
  }
}

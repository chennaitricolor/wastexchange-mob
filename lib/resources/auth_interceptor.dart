import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/resources/api_response_codes.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';

/// Interceptor that modify API Request by adding authentication information to the request.
class AuthInterceptor implements InterceptorContract {
  AuthInterceptor(TokenRepository tokenRepository) {
    _tokenRepository = tokenRepository;
  }

  TokenRepository _tokenRepository;

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    final String token = await _tokenRepository.getToken();
    if (token != null) {
      data.headers['x-access-token'] = token;
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data != null && data.statusCode == APIResponseCodes.UNAUTHORIZED ||
        data.statusCode == APIResponseCodes.FORBIDDEN) {
      await _tokenRepository.deleteToken();
    }
    return data;
  }
}

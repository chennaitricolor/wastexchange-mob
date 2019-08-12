import 'package:http_interceptor/http_interceptor.dart';
import 'package:wastexchange_mobile/resources/auth_repository.dart';

/// Interceptor that modify API Request by adding authentication information to the request.
class AuthInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    await addAuthHeader(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }

  Future<void> addAuthHeader(RequestData data) async {
    final String token = await AuthRepository().getAccessToken();
    if(token != null) {
      data.headers['Authorization'] = token;
    }
  }
}
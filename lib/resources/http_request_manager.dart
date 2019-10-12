import 'package:wastexchange_mobile/models/app_error.dart';
import 'package:wastexchange_mobile/models/http_request.dart';
import 'package:wastexchange_mobile/models/http_response.dart';
import 'package:wastexchange_mobile/resources/http_client.dart';
import 'package:wastexchange_mobile/resources/http_status_codes.dart';

abstract class HttpRequestManager {
  Future<HttpResponse> performRequest(HttpRequest request);
}

class HttpRequestManagerImpl extends HttpRequestManager {
  HttpRequestManagerImpl([HttpClient client]) {
    _client = client ?? HttpClient();
  }

  HttpClient _client;

  @override
  Future<HttpResponse> performRequest(HttpRequest request) async {
    switch (request.method) {
      case HttpMethod.GET:
        final requestResponse = await _client.get(request);
        return requestResponse.response;
      case HttpMethod.POST:
        final requestResponse = await _client.post(request);
        return requestResponse.response;
      case HttpMethod.PUT:
        final requestResponse = await _client.put(request);
        return requestResponse.response;
      default:
        return HttpResponse.error(HttpErrorBadRequest('Invalid httpMethod'),
            HttpStatusCodes.badRequest);
    }
  }
}

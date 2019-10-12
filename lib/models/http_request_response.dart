import 'package:wastexchange_mobile/models/http_request.dart';
import 'package:wastexchange_mobile/models/http_response.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class HttpRequestResponse {
  HttpRequestResponse([this.request, this.response])
      : assert(isNotNull(request)),
        assert(isNotNull(response));
  final HttpRequest request;
  final HttpResponse response;
}

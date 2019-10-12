import 'package:flutter/widgets.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

enum HttpMethod { GET, POST, PUT }

class HttpRequest {
  HttpRequest(
      {@required this.method,
      @required this.url,
      @required this.isAuthenticated,
      this.shouldRetryOn401 = false,
      this.params,
      this.body,
      this.headers})
      : assert(isNotNull(method)),
        assert(isNotNull(url)),
        assert(isNotNull(isAuthenticated)),
        assert(isNotNull(shouldRetryOn401)) {
    headers = headers ?? <String, String>{};
  }
  String url;
  HttpMethod method;
  bool isAuthenticated;
  bool shouldRetryOn401;
  Map<String, dynamic> params;
  Map<String, String> headers;
  dynamic body;
}

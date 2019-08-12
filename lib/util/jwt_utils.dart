import 'dart:convert';

/// Utility class to parse and perform JWT Operations.
class JWTUtils {

  ///Validate JWT Format.
  static bool isValidJWTToken(String token) {

    if(token == null) {
      return false;
    }

    final parts = token.split('.');
    if (parts.length != 3) {
      return false;
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      return false;
    }

    return true;
  }

  /// Parse JWT and return the payload part.
  /// Basically JWT Contains 3 parts. Headers, Payload and Signature.
  static Map<String, dynamic> parseJwtPayload(String token) {

    if(!isValidJWTToken(token)) {
      throw Exception('invalid token');
    }

    final parts = token.split('.');
    final payload = _decodeBase64(parts[1]);
    return json.decode(payload);
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

}

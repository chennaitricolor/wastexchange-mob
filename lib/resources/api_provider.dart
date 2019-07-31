import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/login_response.dart';

class ApiProvider {
 
Future<LoginResponse> login(String loginId, String password) async {
    var map = new Map<String, String> ();
    map['loginId'] = loginId;
    map['password'] = password;
    final response = await http.post('http://data.indiawasteexchange.com/users/login', body: map);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

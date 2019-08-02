import "package:http/http.dart" as http;
import 'package:wastexchange_mobile/common/constants.dart';
import 'package:wastexchange_mobile/models/user.dart';

class UserClient {
  static Future<List<User>> getAllUsers() async {
    var response =
        await http.get(usersListUrl, headers: {"accept": "application/json"});
    if (response.statusCode != 200) {
      throw Exception('failed to fetch users');
    }
    return usersListFromJson(response.body);
  }
}

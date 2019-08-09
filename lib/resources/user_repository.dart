import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/resources/auth_manager.dart';

class UserRepository {
  final UserClient _client = UserClient();

  Future<LoginResponse> login(LoginData loginData) async {
    LoginResponse response = await _client.login(loginData);

    //Set response to AuthManager to persist access token information.
    AuthManager().setAccessToken(response.token);
    return Future.value(response);
  }

  Future<List<User>> getAllUsers() async {
    return await _client.getAllUsers();
  }
}

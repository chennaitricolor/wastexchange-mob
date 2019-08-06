import 'dart:async';

import 'package:wastexchange_mobile/models/api_response.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';

class LoginBloc {
  final UserRepository _userRepository = UserRepository();
  final StreamController _loginController =
      StreamController<ApiResponse<LoginResponse>>();

  StreamSink<ApiResponse<LoginResponse>> get loginSink => _loginController.sink;
  Stream<ApiResponse<LoginResponse>> get loginStream => _loginController.stream;

  Future<void> login(LoginData data) async {
    loginSink.add(ApiResponse.loading('Logging In'));
    try {
      final LoginResponse response = await _userRepository.login(data);
      loginSink.add(ApiResponse.completed(response));
    } catch (e) {
      loginSink.add(ApiResponse.error(e.toString()));
    }
  }

  void dispose() {
    _loginController?.close();
  }
}

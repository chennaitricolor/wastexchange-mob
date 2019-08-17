import 'dart:async';

import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class LoginBloc {
  final UserRepository _userRepository = UserRepository();
  final StreamController _loginController =
      StreamController<Result<LoginResponse>>();

  StreamSink<Result<LoginResponse>> get loginSink => _loginController.sink;
  Stream<Result<LoginResponse>> get loginStream => _loginController.stream;

  Future<void> login(LoginData data) async {
    loginSink.add(Result.loading(Constants.LOADING_LOGIN));
    final Result<LoginResponse> response = await _userRepository.login(data);
    loginSink.add(response);
  }

  void dispose() {
    _loginController.close();
  }
}

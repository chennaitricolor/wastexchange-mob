import 'dart:async';

import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/core/utils/constants.dart';

class LoginBloc {
  final UserRepository _userRepository = UserRepository();
  // TODO(Sayeed): Wrap all streams into a class so that we can do safe adds.
  /*If a stream is closed and we add to it without checking, the app crashes. It can happen on 
  a screen which uses stream to listen to api. When a user enters the screen, an api call is triggered but
  before the response is received, user exits the screen.
  */
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

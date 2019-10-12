import 'dart:async';

import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/models/result_v2.dart';
import 'package:wastexchange_mobile/models/ui_state.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/models/app_error.dart';

class LoginBloc {
  final UserRepository _userRepository = UserRepository();
  final StreamController _loginController =
      StreamController<UIState<LoginResponse, AppError>>();

  StreamSink<UIState<LoginResponse, AppError>> get loginSink =>
      _loginController.sink;
  Stream<UIState<LoginResponse, AppError>> get loginStream =>
      _loginController.stream;

  Future<void> login(LoginData data) async {
    loginSink.add(UIState.loading(Constants.LOADING_LOGIN));
    final ResultV2<LoginResponse, AppError> response =
        await _userRepository.login(data);

    if (response.hasError) {
      loginSink.add(UIState.error(response.error));
    } else {
      loginSink.add(UIState.completed(response.data));
    }
  }

  void dispose() {
    _loginController.close();
  }
}

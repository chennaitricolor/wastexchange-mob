import 'dart:async';

import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';

class RegistrationBloc {
  final logger = getLogger('RegistrationBloc');
  final UserRepository _userRepository = UserRepository();
  final StreamController _registerController =
      StreamController<Result<RegistrationResponse>>();

  StreamSink<Result<RegistrationResponse>> get registrationSink =>
      _registerController.sink;
  Stream<Result<RegistrationResponse>> get registrationStream =>
      _registerController.stream;

  Future<void> register(RegistrationData data) async {
    registrationSink.add(Result.loading(Constants.LOADING_REGISTRATION));
    try {
      final RegistrationResponse response =
          await _userRepository.register(data);
      registrationSink.add(Result.completed(response));
    } catch (e) {
      registrationSink.add(Result.error(e.toString()));
    }
  }

  void dispose() {
    _registerController.close();
  }
}

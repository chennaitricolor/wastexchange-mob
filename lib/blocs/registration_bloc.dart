import 'dart:async';

import 'package:wastexchange_mobile/models/api_response.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/registration_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';

class RegistrationBloc {
  final logger = getLogger('RegistrationBloc');
  final UserRepository _userRepository = UserRepository();
  final StreamController _registerController =
      StreamController<ApiResponse<RegistrationResponse>>();

  StreamSink<ApiResponse<RegistrationResponse>> get registrationSink =>
      _registerController.sink;
  Stream<ApiResponse<RegistrationResponse>> get registrationStream =>
      _registerController.stream;

  Future<void> register(RegistrationData data) async {
    registrationSink.add(ApiResponse.loading(Constants.LOADING_REGISTRATION));
    try {
      final RegistrationResponse response =
          await _userRepository.register(data);
      registrationSink.add(ApiResponse.completed(response));
      logger.i('Bloc completed');
    } catch (e) {
      registrationSink.add(ApiResponse.error(e.toString()));
      logger.i('Bloc error');
    }
  }

  void dispose() {
    _registerController.close();
  }
}

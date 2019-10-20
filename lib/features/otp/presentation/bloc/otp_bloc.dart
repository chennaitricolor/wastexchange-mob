import 'dart:async';

import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/core/utils/app_logger.dart';
import 'package:wastexchange_mobile/core/utils/constants.dart';

class OtpBloc {
  final logger = AppLogger.get('OtpBloc');
  final UserRepository _userRepository = UserRepository();
  final StreamController _otpController =
      StreamController<Result<OtpResponse>>();

  StreamSink<Result<OtpResponse>> get otpSink => _otpController.sink;
  Stream<Result<OtpResponse>> get otpStream => _otpController.stream;

  Future<void> sendOtp(OtpData data) async {
    otpSink.add(Result.loading(Constants.LOADING_OTP));
    final Result<OtpResponse> response = await _userRepository.sendOTP(data);
    otpSink.add(response);
  }

  void dispose() {
    _otpController.close();
  }
}

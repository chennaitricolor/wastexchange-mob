import 'dart:async';

import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';

class OtpBloc {
  final logger = getLogger('OtpBloc');
  final UserRepository _userRepository = UserRepository();
  final StreamController _otpController =
      StreamController<Result<OtpResponse>>();

  StreamSink<Result<OtpResponse>> get otpSink => _otpController.sink;
  Stream<Result<OtpResponse>> get otpStream => _otpController.stream;

  Future<void> sendOtp(OtpData data) async {
    otpSink.add(Result.loading(Constants.LOADING_OTP));
    try {
      final OtpResponse response = await _userRepository.sendOTP(data);
      otpSink.add(Result.completed(response));
    } catch (e) {
      otpSink.add(Result.error(e.toString()));
      logger.e(e.toString());
    }
  }

  void dispose() {
    _otpController.close();
  }
}

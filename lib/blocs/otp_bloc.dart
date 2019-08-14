import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/api_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/otp_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';

class OtpBloc {
  final logger = getLogger('OtpBloc');
  final UserRepository _userRepository = UserRepository();
  final StreamController _otpController =
      StreamController<ApiResponse<OtpResponse>>();

  StreamSink<ApiResponse<OtpResponse>> get otpSink => _otpController.sink;
  Stream<ApiResponse<OtpResponse>> get otpStream => _otpController.stream;

  Future<void> sendOtp(OtpData data) async {
    otpSink.add(ApiResponse.loading(Constants.LOADING_OTP));
    try {
      final OtpResponse response = await _userRepository.sendOTP(data);
      otpSink.add(ApiResponse.completed(response));
    } catch (e) {
      otpSink.add(ApiResponse.error(e.toString()));
      logger.e(e.toString());
    }
  }

  void dispose() {
    _otpController.close();
  }
}

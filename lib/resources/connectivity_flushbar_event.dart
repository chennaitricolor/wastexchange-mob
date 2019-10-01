import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class ConnectivityFlushbarEvent {
  factory ConnectivityFlushbarEvent() => _instance;

  ConnectivityFlushbarEvent._internal() {
    _connectivity = Connectivity();
    _flushbar = Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: const Duration(seconds: 2),
        message: Constants.CONNECT_TO_INTERNET);
  }

  static final ConnectivityFlushbarEvent _instance = ConnectivityFlushbarEvent._internal();
  Connectivity _connectivity;
  Flushbar _flushbar;

  StreamSubscription subscribeToConnectivity(context) {
    return _connectivity.onConnectivityChanged
        .where((data) => data == ConnectivityResult.none)
        .listen((_) {
      _flushbar.show(context);
    });
  }
}

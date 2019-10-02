import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class ConnectivityFlushbarEvent {
  factory ConnectivityFlushbarEvent() => _instance;

  ConnectivityFlushbarEvent._internal() {
    _connectivity = Connectivity();
    _flushbar = Flushbar(
        icon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.network_check,
              size: 30,
              color: Colors.grey,
            )),
        duration: Duration(days: 10),
        backgroundColor: Colors.orange[400],
        forwardAnimationCurve: Curves.ease,
        message: Constants.CONNECT_TO_INTERNET);
  }

  static final ConnectivityFlushbarEvent _instance =
      ConnectivityFlushbarEvent._internal();
  Connectivity _connectivity;
  Flushbar _flushbar;

  StreamSubscription subscribeToConnectivity(context) {
    return _connectivity.onConnectivityChanged.listen((onData) {
      if (onData == ConnectivityResult.none) {
        _flushbar.show(context);
      } else {
        _flushbar.dismiss();
      }
    });
  }
}

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wastexchange_mobile/resources/connectivity_event.dart';
import 'package:wastexchange_mobile/resources/connectivity_event_impl.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class ConnectivityFlushbar {
  final ConnectivityEvent _connectivity = ConnectivityEventImpl();
  final Flushbar _flushbar = Flushbar(
    icon: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Icon(
        Icons.network_check,
        size: 30,
        color: AppTheme.darkerText,
      ),
    ),
    duration: const Duration(days: 10),
    backgroundColor: Colors.orange[300],
    forwardAnimationCurve: Curves.ease,
    messageText: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        Constants.NO_INTERNET_CONNECTION,
        style: AppTheme.body1,
      ),
    ),
  );

  void init(context) {
    _connectivity.subscribe((onData) {
      if (onData == InternetState.unavailable) {
        _flushbar.show(context);
      } else {
        _flushbar.dismiss();
      }
    });
  }

  void dispose() {
    _connectivity.unsubscribe();
  }
}

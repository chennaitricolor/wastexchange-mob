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
          color: Colors.grey[700],
        ),
      ),
      duration: Duration(days: 10),
      backgroundColor: Colors.orange[400],
      forwardAnimationCurve: Curves.ease,
      messageText: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            Constants.CONNECT_TO_INTERNET,
            style: AppTheme.buttonTitle,
        ),
      ),
    );

   void init(context) {
     _connectivity.subscribeToConnectivity((onData) {
      if (onData == InternetState.UNAVAILABLE) {
        _flushbar.show(context);
      } else {
        _flushbar.dismiss();
      }
    });
  }

  void dispose() {
     _connectivity.unsubscribeToConnectivity();
  }
}

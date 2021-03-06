import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:wastexchange_mobile/resources/connectivity_event.dart';

class ConnectivityEventImpl implements ConnectivityEvent {
  StreamSubscription _streamSubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void subscribe(void onInternetStateData(InternetState event)) {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((onData) {
      if (onData == ConnectivityResult.none) {
        onInternetStateData(InternetState.unavailable);
      } else {
        onInternetStateData(InternetState.available);
      }
    });
  }

  @override
  void unsubscribe() {
    _streamSubscription.cancel();
  }
}

enum InternetState { available, unavailable }

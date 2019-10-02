import 'package:wastexchange_mobile/resources/connectivity_event_impl.dart';

abstract class ConnectivityEvent {
  void subscribeToConnectivity(void onInternetStateData(InternetState event)) {}
  void unsubscribeToConnectivity() {}
}
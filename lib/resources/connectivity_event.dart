import 'package:wastexchange_mobile/resources/connectivity_event_impl.dart';

abstract class ConnectivityEvent {
  void subscribe(void onInternetStateData(InternetState event)) {}
  void unsubscribe() {}
}

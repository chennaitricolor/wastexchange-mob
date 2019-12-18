import 'dart:async';

import 'package:clustering_google_maps/clustering_google_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class MapBloc {
  final UserRepository _userRepository = UserRepository();
  final StreamController _allUsersController =
      StreamController<Result<List<User>>>();
  List<User> _users = [];

  StreamSink<Result<List<User>>> get allUsersSink => _allUsersController.sink;
  Stream<Result<List<User>>> get allUsersStream => _allUsersController.stream;

  Future<void> getAllUsers() async {
    allUsersSink.add(Result.loading(Constants.LOADING_LOGIN));
    final Result<List<User>> response = await _userRepository.getAllUsers();
    // TODO(Sayeed): Can we improve this. Examining the state and doing computations here feels off.
    if (response.status == Status.completed) {
      _users = _removeBuyersFromUsers(response.data);
      allUsersSink.add(Result.completed(_users));
      return;
    }
    allUsersSink.add(response);
  }

  User getUser(int id) {
    return _users.firstWhere((user) => user.id == id);
  }

  void getMapInitialLatLng() {}

  List<User> _removeBuyersFromUsers(List<User> users) {
    users.removeWhere((user) => user.persona != Constants.USER_SELLER);
    return users;
  }

  List<LatLngAndGeohash> getUsersLocationList() {
    final List<LatLngAndGeohash> locationList= [];
    for(int i=0; i < _users.length; i++){
      final user = _users[i];
      locationList.add(LatLngAndGeohash(LatLng(user.lat, user.long)));
    }
    return locationList;
  }

  void dispose() {
    _allUsersController.close();
  }
}

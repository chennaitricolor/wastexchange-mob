import 'dart:async';

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
    if (response.status == Status.COMPLETED) {
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

  void dispose() {
    _allUsersController.close();
  }
}

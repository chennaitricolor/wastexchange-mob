import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/launch_setup.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/resources/env_repository.dart';
import 'package:wastexchange_mobile/resources/key_value_store.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/screens/app_home_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';

Future<void> main() async {
  await LaunchSetup(members: [
    AppLogger(),
    EnvRepository(),
    TokenRepository(),
    UserRepository(),
    KeyValueStore()
  ]).load();
  runApp(AppHomeScreen());
}



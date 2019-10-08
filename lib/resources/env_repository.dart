import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wastexchange_mobile/launch_setup.dart';

class EnvRepository implements LaunchSetupMember {
  factory EnvRepository() {
    return _singleton;
  }

  EnvRepository._internal([DotEnv env]) {
    _env = env ?? DotEnv();
  }

  static final EnvRepository _singleton = EnvRepository._internal();

  static const loggerLevel = 'LOGGER_LEVEL';
  static const baseApiUrl = 'BASE_API_URL';
  DotEnv _env;

  @override
  Future<void> load() async {
    await _env.load('.env');
  }

  dynamic getValue({@required String key}) {
    return _env.env[key];
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvRepository {
  EnvRepository({DotEnv env}) {
    _env = env ?? DotEnv();
  }

  static const loggerLevel = 'LOGGER_LEVEL';
  static const baseApiUrl = 'BASE_API_URL';
  DotEnv _env;

  Future<void> load() async {
    await _env.load('.env');
  }

  dynamic getValue({@required String key}) {
    return _env.env[key];
  }
}

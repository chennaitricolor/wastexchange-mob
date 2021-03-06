import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/resources/env_repository.dart';
import 'package:wastexchange_mobile/resources/key_value_data_store.dart';
import 'package:wastexchange_mobile/resources/platform_info_repository.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';

// TODO(Sayeed): Is this a good name for this mixin
mixin LaunchSetupMember {
  Future<void> load();
}

class LaunchSetup {
  final List<LaunchSetupMember> _members = [
    EnvRepository(),
    AppLogger(),
    TokenRepository(),
    UserRepository(),
    KeyValueDataStore(),
    PlatformInfoRespositoryImpl()
  ];

  Future<void> load() async {
    for (LaunchSetupMember member in _members) {
      await member.load();
    }
  }
}

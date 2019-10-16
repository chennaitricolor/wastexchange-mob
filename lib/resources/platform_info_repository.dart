import 'dart:io' show Platform;
import 'package:get_version/get_version.dart';
import 'package:package_info/package_info.dart';
import 'package:wastexchange_mobile/launch_setup.dart';
import 'package:wastexchange_mobile/models/platform_info.dart';

// TODO(Sayeed): Rethink this class name. Should we call this class a manager or provider.
abstract class PlatformInfoRespository {
  PlatformInfo getPlatformInfo();
}

class PlatformInfoRespositoryImpl
    implements PlatformInfoRespository, LaunchSetupMember {
  factory PlatformInfoRespositoryImpl() {
    return _singleton;
  }

  // TODO(Sayeed): Check if this is how abstract classes and impl are declared
  PlatformInfoRespositoryImpl._internal();

  static final PlatformInfoRespositoryImpl _singleton =
      PlatformInfoRespositoryImpl._internal();
  PlatformInfo _platformInfo;

  @override
  Future<void> load() async {
    final platformOSVersion = await GetVersion.platformVersion;
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String appName = packageInfo.appName;
    final String appVersion = packageInfo.version;
    final String appBuildNumber = packageInfo.buildNumber;
    final platformOS = Platform.operatingSystem;

    _platformInfo = PlatformInfo(
        appName, appVersion, appBuildNumber, platformOS, platformOSVersion);
  }

  @override
  PlatformInfo getPlatformInfo() => _platformInfo;
}

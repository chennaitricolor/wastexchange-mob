import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceInfo {
  DeviceInfoPlugin deviceInfo;

  DeviceInfo() {
    this.initDeviceInfo();
  }

  initDeviceInfo() {
    this.deviceInfo = DeviceInfoPlugin();
  }

  /*
    Check minimum Hardware/Software requirements to run flutter application.
    Mobile operating systems: Android Jelly Bean, v16, 4.1.x or newer, and iOS 8 or newer.
    Mobile hardware: iOS devices (iPhone 4S or newer) and ARM Android devices.
    Reference: https://flutter.dev/docs/resources/faq#what-devices-and-os-versions-does-flutter-run-on
  */
  Future<bool> isValidDevice() async {

    if (Platform.isAndroid) {
      return await this.checkAndroidRequirments();
    }

    if(Platform.isIOS){
      return await this.checkIOSRequirments();
    }

    return false;
  }

  Future<bool> checkIOSRequirments() async {
    IosDeviceInfo iosInfo = await this.deviceInfo.iosInfo;
    if(double.parse(iosInfo.systemVersion) >= 8){
      return true;
    }

    return false;
  }

  Future<bool> checkAndroidRequirments() async {
    AndroidDeviceInfo androidInfo = await this.deviceInfo.androidInfo;
    AndroidBuildVersion androidVersion = androidInfo.version;

    if(androidVersion.sdkInt >= 16 ){
      return true;
    }
    return false;
  }
}

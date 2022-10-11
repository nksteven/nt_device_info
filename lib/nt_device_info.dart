import 'dart:async';

import 'package:flutter/services.dart';

class NtDeviceInfoPlugin {
  NtDeviceInfoPlugin();
  static const MethodChannel _channel = const MethodChannel('nt_device_info');

  static Future<IosDeviceInfo> get iosDeviceInfo async {
    final Map info = await _channel.invokeMethod('getIosDeviceInfo');
    return IosDeviceInfo.fromMap(info);
  }
}

class IosDeviceInfo {
  /// IOS device info class.
  IosDeviceInfo({
    this.name,
    this.systemName,
    this.systemVersion,
    this.model,
    this.localizedModel,
    this.identifierForVendor,
    this.utsname,
  });

  /// Device name.
  final String name;

  /// The name of the current operating system.
  final String systemName;

  /// The current operating system version.
  final String systemVersion;

  /// Device model.
  final String model;

  /// Localized name of the device model.
  final String localizedModel;

  /// Unique UUID value identifying the current device.
  final String identifierForVendor;

  /// Operating system information derived from `sys/utsname.h`.
  final IosUtsname utsname;

  /// Deserializes from the map message received from [_kChannel].
  static IosDeviceInfo fromMap(Map<dynamic, dynamic> map) {
    return IosDeviceInfo(
      name: map['name'],
      systemName: map['systemName'],
      systemVersion: map['systemVersion'],
      model: map['model'],
      localizedModel: map['localizedModel'],
      identifierForVendor: map['identifierForVendor'],
      utsname:
          IosUtsname._fromMap(map['utsname']?.cast<String, dynamic>() ?? {}),
    );
  }
}

/// Information derived from `utsname`.
/// See http://pubs.opengroup.org/onlinepubs/7908799/xsh/sysutsname.h.html for details.
class IosUtsname {
  IosUtsname._({
    this.machine,
  });

  /// Hardware type (e.g. 'iPhone7,1' for iPhone 6 Plus).
  final String machine;

  /// Deserializes from the map message received from [_kChannel].
  static IosUtsname _fromMap(Map<dynamic, dynamic> map) {
    return IosUtsname._(
      machine: map['machine'].toString(),
    );
  }
}

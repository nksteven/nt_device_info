import Flutter
import UIKit

public class SwiftNtDeviceInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "nt_device_info", binaryMessenger: registrar.messenger())
    let instance = SwiftNtDeviceInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "getIosDeviceInfo" {
          let device = UIDevice.current
          var systemInfo = utsname()
          uname(&systemInfo);
          result([
            "name": device.name,
            "systemName" : device.systemName,
            "systemVersion" : device.systemVersion,
            "model" : device.model,
            "localizedModel" : device.localizedModel,
            "identifierForVendor" : device.identifierForVendor?.uuidString ?? "",
            "utsname" : [
                "machine" : withUnsafePointer(to: &systemInfo.machine.0, { ptr in
                    return String(cString: ptr)
                }),
            ]
          ]);
      }else {
          result(FlutterMethodNotImplemented);
        }
  }
}

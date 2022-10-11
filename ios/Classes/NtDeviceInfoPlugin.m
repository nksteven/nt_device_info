#import "NtDeviceInfoPlugin.h"
#if __has_include(<nt_device_info/nt_device_info-Swift.h>)
#import <nt_device_info/nt_device_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nt_device_info-Swift.h"
#endif

@implementation NtDeviceInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNtDeviceInfoPlugin registerWithRegistrar:registrar];
}
@end

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nt_device_info/nt_device_info.dart';

void main() {
  const MethodChannel channel = MethodChannel('nt_device_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await NtDeviceInfoPlugin.platformVersion, '42');
  });
}

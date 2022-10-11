import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nt_device_info/nt_device_info.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _machine = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String machineName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // platformVersion = await NtDeviceInfoPlugin.platformVersion;
      if (Platform.isIOS) {
        IosDeviceInfo info = await NtDeviceInfoPlugin.iosDeviceInfo;
        machineName = info.utsname.machine;
        // machineName = info.name;
      }
    } on PlatformException {
      machineName = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _machine = machineName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_machine\n'),
        ),
      ),
    );
  }
}

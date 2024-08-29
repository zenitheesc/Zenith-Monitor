import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:zenith_monitor/modules/bluetooth/device_caracteristics_screen.dart';
import './MainPage.dart';

class BluetoothScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleApplication(),
    );
  }
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

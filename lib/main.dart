import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';

void main() {
  runApp(ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  ZenithMonitor({Key? key}) : super(key: key);

  final LocationManager data = LocationManager();
  @override
  Widget build(BuildContext context) {
    data.init();
    return MaterialApp(
      home: Container(),
    );
  }
}

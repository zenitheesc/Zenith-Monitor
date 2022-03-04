import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'modules/map/screen/map_screen.dart';

const bool debugEnableDeviceSimulator = true;
void main() {
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    return const MaterialApp(
      home: MapScreen(),
    );
  }
}

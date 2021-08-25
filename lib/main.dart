import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/services/location.dart';
import 'package:zenith_monitor/widgets/login.dart';

void main() {
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Application(),
    );
  }
}

class Application extends StatelessWidget {
  LocationManager a = LocationManager();

  @override
  Widget build(BuildContext context) {
    a.init();
    a.check();
    print(a.receive());
    print(a.status());
    a.dispose();

    return LoginZenithMonitor();
  }
}

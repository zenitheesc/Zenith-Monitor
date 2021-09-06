import 'package:flutter/material.dart';
import 'package:zenith_monitor/widgets/exampleLocation.dart';

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

  @override
  Widget build(BuildContext context) {

    return ExampleLocation();
  }
}

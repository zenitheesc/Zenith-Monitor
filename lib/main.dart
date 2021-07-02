import 'package:flutter/material.dart';
import 'package:zenith_monitor/widgets/aboutUs-zenithmonitor.dart';
import 'package:zenith_monitor/widgets/nossosValores.dart';

void main() {
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pagina(),
    );
  }
}

class Pagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutUsZenithMonitor();
  }
}

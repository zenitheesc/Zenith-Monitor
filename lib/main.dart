import 'package:flutter/material.dart';
import 'package:zenith_monitor/widgets/connections.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';

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
  Connection usb = Connection("Conexão USB", false);
  Connection blue = Connection("Conexão Bluetooth", false);
  Connection fire = Connection("Conexão Firebase", false);
  Connection batata = Connection("Conexão Batata", true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(title: "Conexões",),
      body: ConnectionDisplay(connections: [usb,blue,fire,batata])
    );
  }
}

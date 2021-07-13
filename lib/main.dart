import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
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

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Connection usb = Connection("Conexão USB", true);

  Connection blue = Connection("Conexão Bluetooth", false);

  Connection fire = Connection("Conexão Firebase", true);

  Connection batata = Connection("Conexão Batata", true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: eerieBlack,
      appBar: StandardAppBar(title: "Conexões",),
      body: Padding (
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[ConnectionDisplay(connections: [usb,blue,fire]),
          ]
        )
      )
    );
  }
}

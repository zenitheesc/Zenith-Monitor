import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/mission_creation.dart';

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
    return Scaffold(
      appBar: AppBar(
          title: const Text('Criação de Missão'),
          backgroundColor: eerieBlack,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: gray)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MissionCreation(),
          ],
        ),
      ),
      backgroundColor: eerieBlack,
    );
  }
}

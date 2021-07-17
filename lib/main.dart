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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width*0.83,
              child: 
                Text('Criação de Missão',
                  style: const TextStyle(
                    color: gray,
                    fontSize: 12.0
                  ),
                )
            ),
            SizedBox(height: 20,),
            MissionCreation(),
          ],
        ),
      ),
      backgroundColor: eerieBlack,
    );
  }
}

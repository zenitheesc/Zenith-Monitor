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
      body: Center( /// retirei o "criação de missão" daqui porque ele deve fazer parte do nosso componente
        child: Column( /// retirei os alinhamentos da column pq isso será responsabilidade de quem criar a pagina inteira
          children: <Widget>[
	    SizedBox(height: 20,),
            MissionCreation(),
          ],
        ),
      ),
      backgroundColor: eerieBlack,
    );
  }
}

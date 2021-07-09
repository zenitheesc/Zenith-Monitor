import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';

class ConnectionDisplay extends StatelessWidget {
  ConnectionDisplay ({Key? key, required this.connections,});

  final List<Connection> connections;

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.83,
        decoration: const BoxDecoration(
          color: raisingBlack,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      child: Table(
        columnWidths: {
              0: FractionColumnWidth(2/3),
              1: FractionColumnWidth(1/3),
        },
          children:[
              for (var connection in connections) 
                Func(connection)
          ]
      ),
    );
  }

  TableRow Func(Connection connection) {
    return TableRow(children: [
      Expanded(child:
        Text(
        connection.getType(),
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          color: white,
          fontFamily: 'DMSans',
        ),
        ),
      ),
      Text(
        connection.getstate() ? 'Ativado' : 'Desativado',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: connection.getstate() ? mantisGreen : lightCoral,
          fontFamily: 'DMSans',
        ),
        textAlign: TextAlign.center,
      ),
      ]);
}
}
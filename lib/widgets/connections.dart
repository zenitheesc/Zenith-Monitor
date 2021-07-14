import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';

class ConnectionDisplay extends StatelessWidget {
  ConnectionDisplay ({Key? key, required this.connections,});

  final List<Connection> connections;

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7.5,7.5,7.5,7.5),
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
            func(connection)
        ]
      ),
    );
  }

  TableRow func(Connection connection) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
          child: Text(
            connection.getType(),
            style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: white,
            fontFamily: 'DMSans',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
          child: Text(
          connection.getState() ? 'Ativado' : 'Desativado',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: connection.getState() ? mantisGreen : lightCoral,
            fontFamily: 'DMSans',
          ),
          textAlign: TextAlign.center,
          ),
        )
      ]
    );
  }
}

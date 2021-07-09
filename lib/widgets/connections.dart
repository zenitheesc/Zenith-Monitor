import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';

class ConnectionDisplay extends StatelessWidget {
  ConnectionDisplay ({Key? key, required this.connections,});

  final List<Connection> connections;

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
          children:[
              for (var connection in connections) 
                Func(connection)
          ]
      ),
    );
  }

  TableRow Func(Connection connection) {
    return TableRow(children: [
              Text(connection.getType()),
              Text(connection.getstate() ? 'Ativado' : 'Desativado'),
              ]);
  }
}
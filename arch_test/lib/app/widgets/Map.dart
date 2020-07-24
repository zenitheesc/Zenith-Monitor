import 'dart:convert';

import 'package:arch_test/app/models/StandartPacket.dart';
import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  final Stream<StdPacket> input;
  MapView({Key key, this.input}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<StdPacket> accumulator = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: widget.input,
          builder: (context, AsyncSnapshot<StdPacket> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done)
              accumulator.add(snapshot.data);
            return ListView.builder(
                itemCount: accumulator.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    title: Text(accumulator[index].x.toString()),
                  );
                });
          }),
    );
  }
}

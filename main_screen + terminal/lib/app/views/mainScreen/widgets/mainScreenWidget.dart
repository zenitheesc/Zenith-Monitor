import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'lineofbuttons.dart';
import 'scrollabledraggablesheet.dart';
import 'sidebar.dart';
import '../datatypes.dart';
import '../map.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<MapSampleState> __mapKey = GlobalKey<MapSampleState>();
  StreamController<MapType> mapStreamController = StreamController<MapType>();

  void dispose() {
    mapStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          MapSample(__mapKey, mapStreamController),
          Align(
            alignment: Alignment(-0.9, -0.9),
            child: LineOfButtons(__mapKey, mapStreamController),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableSheet(),
          ),
        ],
      ),
      drawer: SideBar(user),
      drawerEnableOpenDragGesture: true,
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/views/mainScreen/gmap.dart';

import './lineOfButtons.dart';
import './scrollableDraggableSheet.dart';
import 'sidebar.dart';
import '../datatypes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          GMapsConsumer(),
          Align(
            alignment: Alignment(-0.9, -0.9),
            child: LineOfButtons(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableSheet(),
          ),
        ],
      ),
      drawer: SideBar(user),
      // drawerEnableOpenDragGesture: true,
    );
  }
}

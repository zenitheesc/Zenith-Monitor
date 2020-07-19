import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Widgets/lineofbuttons.dart';
import 'datatypes.dart';
import 'Widgets/scrollabledraggablesheet.dart';
import 'Widgets/sidebar.dart';
import 'map.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<MapSampleState> mapKey = GlobalKey<MapSampleState>();
  StreamController<MapType> mapStreamController = StreamController<MapType>();

  void dispose() {
    mapStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Screen',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            MapSample(mapKey, mapStreamController),
            Align(
              alignment: Alignment(-0.9, -0.9),
              child: LineOfButtons(scaffoldKey, mapKey, mapStreamController),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DraggableSheet(),
            ),
          ],
        ),
        drawer: SideBar(user),
        drawerEnableOpenDragGesture: true,
      ),
    );
  }
}

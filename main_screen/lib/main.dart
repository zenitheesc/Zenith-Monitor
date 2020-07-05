import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zenith_monitor/datatypes.dart';
import 'Widgets/scrollabledraggablesheet.dart';
import 'Widgets/sidebar.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
            Align(
              alignment: Alignment.bottomCenter,
              child: DraggableSheet(),
            ),
            Align(
                alignment: Alignment(-0.9, -0.9),
                child: FloatingActionButton(
                  onPressed: () => scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.list),
                  foregroundColor: Colors.black54,
                  backgroundColor: Colors.white,
                )),
          ],
        ),
        drawer: SideBar(user),
        drawerEnableOpenDragGesture: true,
      ),
    );
  }
}

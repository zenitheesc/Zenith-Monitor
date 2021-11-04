import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => Mapp();
}

class Mapp extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  PolylinePoints polylinePoints = PolylinePoints();

  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;

  Future<void> _add() async {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: _createPoints(),
    );

    setState(() {
      _mapPolylines[polylineId] = polyline;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-20.554331116, -48.567331064),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    markers.addAll([
      Marker(
          markerId: MarkerId('value'),
          position: LatLng(-20.554331116, -48.567331064)),
      Marker(
          markerId: MarkerId('value2'),
          position: LatLng(-20.7333333, -48.5833333)),
    ]);

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: raisingBlack,
        toolbarHeight: 5,
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: _add)],
      ),
      body: Stack(children: <Widget>[
        Positioned(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              _mapController = controller;
              var style =
                  await rootBundle.loadString('assets/maps/aubergine.json');
              _add();
              _mapController.setMapStyle(style);
              _controller.complete(controller);
            },
            markers: markers,
            polylines: Set<Polyline>.of(_mapPolylines.values),
          ),
        ),
        Positioned(
          bottom: 200,
          top: 0,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
        Positioned(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: raisingBlack,
                  boxShadow: [
                    BoxShadow(color: gray, spreadRadius: 1),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    informations(
                        context, 'Altitude', 'Velocidade', '5000m', '9m/s'),
                    informations(
                        context, 'Latitude', 'Longitude', '90º', '30º'),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(LatLng(-20.554331116, -48.567331064));
    points.add(LatLng(-20.7333333, -48.5833333));
    // points.add(LatLng(8.196142, 2.094979));
    // points.add(LatLng(12.196142, 3.094979));
    // points.add(LatLng(16.196142, 4.094979));
    // points.add(LatLng(20.196142, 5.094979));
    return points;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = white;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      3 * math.pi / 2,
      math.pi,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}

double screenSize(BuildContext context, String type, double size) {
  if (type == "height")
    return MediaQuery.of(context).size.height * size;
  else
    return MediaQuery.of(context).size.width * size;
}

Widget insertText(BuildContext context, String text, String input) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: TextStyle(
            color: white,
            fontSize: screenSize(context, "width", 0.04),
            fontFamily: 'DMSans'),
      ),
      Text(input,
          style: TextStyle(
              color: white,
              fontSize: screenSize(context, "width", 0.03),
              fontFamily: 'DMSans')),
    ],
  );
}

Widget informations(BuildContext context, String text1, String text2,
    String input1, String input2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      informationsContainer(context, text1, input1),
      informationsContainer(context, text2, input2)
    ],
  );
}

Widget informationsContainer(BuildContext context, String text, String input) {
  return Container(
    decoration: BoxDecoration(
      color: eerieBlack,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: gray, spreadRadius: 1),
      ],
    ),
    width: screenSize(context, "width", 0.44),
    height: screenSize(context, "height", 0.1),
    child: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(image: AssetImage('assets/images/award.png')),
        insertText(context, text, input),
      ],
    )),
  );
}

Widget smallContainer(BuildContext context, String text, int textColor) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: white,
              fontSize: screenSize(context, "width", 0.048),
              fontFamily: 'DMSans'),
        ),
        onPressed: () {
          print(text + ' Pressed!');
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        screenSize(context, "height", 0.03125)),
                    side: BorderSide(color: Color(textColor)))),
            fixedSize: MaterialStateProperty.all(Size(
              screenSize(context, "width", 0.4),
              screenSize(context, "height", 0.05847),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(textColor),
            )),
      ),
    ),
  );
}

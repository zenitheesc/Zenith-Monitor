import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => Map();
}

class Map extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-20.554331116, -48.567331064),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //     body:
  //     floatingActionButton: FloatingActionButton.extended(
  //       onPressed: _goToTheLake,
  //       label: Text('To the lake!'),
  //       icon: Icon(Icons.directions_boat),
  //     ),
  //   );
  // }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: raisingBlack,
        toolbarHeight: 3,
      ),
      body: Stack(children: <Widget>[
        Positioned(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              // _mapController = controller;
              // var style = await rootBundle.loadString('assets/maps/dark.json');
              // _mapController.setMapStyle(style);

              _controller.complete(controller);
            },
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
        Positioned(
            bottom: -240,
            top: -10,
            left: -30,
            child: Center(
              child: Container(
                child: CustomPaint(
                  painter: MyPainter(),
                  size: Size(70, 40),
                ),
              ),
            )),
      ]),
    );
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
    // TODO: implement shouldRepaint
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

import 'dart:async';

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
            // mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              _mapController = controller;
              var style = await rootBundle.loadString('assets/maps/dark.json');
              _mapController.setMapStyle(style);

              _controller.complete(controller);
            },
          ),
        ),
        Positioned(
          bottom: 200,
          top: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        Positioned(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(color: raisingBlack),
                child: Center(),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

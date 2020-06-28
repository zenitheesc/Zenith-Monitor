import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // only used here for the LatLng class

import 'package:firstattemptatmaps/models/map_event.dart';
import 'package:firstattemptatmaps/widgets/gmap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      debugShowCheckedModeBanner: false,
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Stream<TargetTrajectory> incomingStream;

  MapSampleState() {
    // Generates a temporary stream to mock incoming data
    incomingStream = Stream<TargetTrajectory>.periodic(Duration(seconds: 3),
        (int eventCount) {
      var r = new Random();
      var p = TargetTrajectory(
          id: eventCount,
          position: LatLng(-22.90 + r.nextDouble(), -43.20 + r.nextDouble()),
          altitude: r.nextDouble(),
          speed: r.nextDouble());
      return p;
    }).take(7); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GMapsConsumer(
          // [Hopefully] is this simple
          input: incomingStream,
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';
import 'package:firstattemptatmaps/bloc/data_bloc/data_bloc.dart';
import 'package:firstattemptatmaps/bloc/location_bloc/location_bloc.dart';
import 'package:firstattemptatmaps/components/data.dart';
import 'package:firstattemptatmaps/components/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // only used here for the LatLng class

import 'package:firstattemptatmaps/models/map_event.dart';
import 'package:firstattemptatmaps/widgets/gmap.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      debugShowCheckedModeBanner: false,
      home: MapSample(),
      showPerformanceOverlay: true,
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Stream<TargetTrajectory> incomingStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => DataBloc(DataManager()),
      child: Stack(
        children: <Widget>[
          BlocProvider(
            create: (context) => LocationBloc(LocationManager()),
            child: GMapsConsumer(),
          ),
        ],
      ),
    ));
  }
}

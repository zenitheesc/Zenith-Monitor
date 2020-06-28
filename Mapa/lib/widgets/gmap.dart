import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firstattemptatmaps/models/map_event.dart';
import 'package:location/location.dart';

class GMapsConsumer extends StatefulWidget {
  final Stream<TargetTrajectory> input;
  GMapsConsumer({Key key, @required this.input}) : super(key: key);

  @override
  _GMapsConsumerState createState() => _GMapsConsumerState();
}

class _GMapsConsumerState extends State<GMapsConsumer> {
  StreamSubscription<LocationData> user_position;
  var user_loc = LatLng(-22.00144, -47.93198); // SC
  List<TargetTrajectory> points = [];

  var location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _GMapsConsumerState() {
    _initLocation().then((loc) => user_loc = loc);

    user_position = location.onLocationChanged.listen((loc) {
      setState(() => user_loc = LatLng(loc.latitude, loc.longitude));
    });
  }

  @override
  void dispose() {
    user_position.cancel();
    super.dispose();
  }

  Future<LatLng> _initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('location service is disabled');
        return user_loc;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('permission was denied');
        return user_loc;
      }
    }

    var loc = await location.getLocation();
    return LatLng(loc.latitude, loc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<TargetTrajectory>(
          stream: widget.input,
          initialData: TargetTrajectory(id: -1),
          builder: (context, AsyncSnapshot<TargetTrajectory> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||snapshot.connectionState == ConnectionState.done ) {
              if (snapshot.data.id > -1) points.add(snapshot.data);
              return Center(
                  child: GMapsView(
                target_points: points,
                user_position: user_loc,
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Text("stream disconnected"),
              );
            }
          }),
    );
  }
}

class GMapsView extends StatefulWidget {
  final List<TargetTrajectory> target_points;
  final LatLng user_position;
  GMapsView({Key key, this.target_points, this.user_position})
      : super(key: key);

  @override
  _GMapsViewState createState() => _GMapsViewState();
}

class _GMapsViewState extends State<GMapsView> {
  var _initialPosition = CameraPosition(
    target: LatLng(-22.9034, -43.2655), // SC
    zoom: 7.0,
  );

  Completer<GoogleMapController> _controller = Completer();

  _GMapsViewState() {}

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    Set<Polyline> lines = {};
    List<LatLng> loc_to_device = [
      widget.user_position,
      widget.target_points.last.position
    ];

    for (var position in widget.target_points) {
      Marker m = Marker(
          position: position.position,
          zIndex: position.altitude,
          alpha: 0.75,
          infoWindow: InfoWindow(
              title: "Alt: ${position.altitude.toStringAsFixed(4)}",
              snippet:
                  "(${position.position.latitude.toStringAsFixed(4)},${position.position.latitude.toStringAsFixed(4)})"),
          markerId: MarkerId((position.position.longitude +
                  position.position.latitude)
              .toString()) // this is problematic;.toStringAsFixed(4) solution use received index
          );
      markers.add(m);

      var device_path = Polyline(
          polylineId: PolylineId("device_path"),
          consumeTapEvents: false,
          color: Colors.pink,
          width: 2,
          points: widget.target_points.map((e) => e.position).toList(),
          zIndex: 1);
      lines.add(device_path);
      var ltd = Polyline(
        polylineId: PolylineId("loc_to_device"),
        consumeTapEvents: false,
        color: Colors.blue,
        width: 5,
        points: loc_to_device.map((e) => e).toList(),
        zIndex: 0,
      );
      lines.add(ltd);
    }

    return Container(
      child: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        mapToolbarEnabled: false,
        polylines: lines,
        compassEnabled: true,
      ),
    );
  }
}

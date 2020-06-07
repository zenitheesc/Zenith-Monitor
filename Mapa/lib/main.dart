import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  MapSampleState() {
    _getLocation().then((LatLng loc) async{
      setState(() {
        loc_to_device[0] = loc;
        loc_to_device[1] = loc;
      });
      final GoogleMapController controller = await _controller.future;
      CameraPosition cp = CameraPosition(
          target: loc,
          zoom: 15);
      controller.animateCamera(CameraUpdate.newCameraPosition(cp));
    });
  }
  Completer<GoogleMapController> _controller = Completer();
  var rng = new Random();
  List<LatLng> device_coordinates = [
    // LatLng(-22.00698, -47.89676),
    // LatLng(-22.00144, -47.93198),
    // LatLng(-21.98365, -47.88166),
  ];
  List<LatLng> loc_to_device = [
    LatLng(-22.00698, -47.89676),
    LatLng(-22.00698, -47.89676),
  ];
  Set<Polyline> lines = {};

  var _initialPosition = CameraPosition(
    target: LatLng(-22.00698, -47.89676), // SC
    zoom: 13.5,
  );

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    for (var position in device_coordinates) {
      Marker m = Marker(
          position: position,
          markerId: MarkerId((position.longitude + position.latitude)
              .toString()) // this is problematic; solution use received index
          );
      markers.add(m);
    }

    lines = {
      Polyline(
        polylineId: PolylineId("device_path"),
        consumeTapEvents: false,
        color: Colors.pink,
        width: 2,
        points: device_coordinates,
      ),
      Polyline(
        polylineId: PolylineId("loc_to_device"),
        consumeTapEvents: false,
        color: Colors.blue,
        width: 5,
        points: loc_to_device,
      )
    };

    return new Scaffold(
        // appBar: AppBar(
        //   title: Text("First Maps"),
        //   actions: <Widget>[],
        // ),
        body: GoogleMap(
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(),
            FloatingActionButton(
              onPressed: _goHome,
              child: Icon(Icons.home),
            ),
            Spacer(),
            FloatingActionButton.extended(
              onPressed: _addNewPoint,
              label: Text('Add'),
              icon: Icon(Icons.location_on),
            ),
            Spacer(),
            FloatingActionButton.extended(
              onPressed: _setBearingView,
              label: Text('Point to Device'),
              icon: Icon(Icons.arrow_upward),
            ),
            Spacer(),
          ],
        ));
  }

  LatLng _generateRandomSC() {
    var r = rng.nextDouble(); // 0.x
    if (rng.nextBool()) r *= -1;
    if (rng.nextBool()) r *= r;
    var lat = -22.000;
    lat += r / 10;
    r = rng.nextDouble();
    if (rng.nextBool()) r *= -1;
    if (rng.nextBool()) r *= r;
    var lng = -47.90;
    lng += r / 10;
    return LatLng(lat, lng);
  }

  Future<void> _goHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
  }
  void _addNewPoint() {
    setState(() {
      var point = _generateRandomSC();
      device_coordinates.add(point);
      loc_to_device[1] = point;
    });
  }

  Future<LatLng> _getLocation() async {
    // Location location = new Location();
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     print('permission error');
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     print('permission error');
    //   }
    // }

    // _locationData = await location.getLocation();
    // return LatLng(_locationData.latitude,_locationData.longitude);
    return Future.delayed(Duration(seconds: 1), () {
      return LatLng(-22.00144, -47.93198);
    });
  }

  double _radians(double degrees) {
    return degrees * (pi / 180);
  }

  double _bearing(LatLng p1, LatLng p2) {
    var lat1 = _radians(p1.latitude);
    var lat2 = _radians(p2.latitude);
    var long1 = _radians(p1.longitude);
    var long2 = _radians(p2.longitude);
    var y = sin(long2 - long1) * cos(lat2);
    var x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(long2 - long1);
    var theta = atan2(y, x);
    return (theta * 180 / pi + 360) % 360; // in degrees
  }

  Future<void> _setBearingView() async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cp = CameraPosition(
        bearing: _bearing(loc_to_device[0], loc_to_device[1]),
        target: LatLng(loc_to_device[0].latitude, loc_to_device[0].longitude),
        tilt: 70.0,
        zoom: 17);
    controller.animateCamera(CameraUpdate.newCameraPosition(cp));
  }
}

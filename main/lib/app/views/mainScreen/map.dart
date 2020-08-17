import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionData {
  LatLng gps;
  double altitude = 0;
  int time;
  PositionData({this.gps, this.altitude});
}

class MapSample extends StatefulWidget {
  StreamController<MapType> mapStreamController = StreamController<MapType>();
  MapSample(Key key, this.mapStreamController) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  var scaffoldMapKey = GlobalKey<ScaffoldState>();

  MapSampleState() {
    _getLocation().then((PositionData loc) async {
      setState(() {
        loc_to_device[0] = loc;
        loc_to_device[1] = loc;
      });
      final GoogleMapController controller = await _controller.future;
      CameraPosition cp = CameraPosition(target: loc.gps, zoom: 15);
      controller.animateCamera(CameraUpdate.newCameraPosition(cp));
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  var rng = new Random();
  List<PositionData> device_coordinates = [
    // LatLng(-22.00698, -47.89676),
    // LatLng(-22.00144, -47.93198),
    // LatLng(-21.98365, -47.88166),
  ];
  List<PositionData> loc_to_device = [
    PositionData(gps: LatLng(-22.00698, -47.89676)),
    PositionData(gps: LatLng(-22.00698, -47.89676)),
  ];
  Set<Polyline> lines = {};

  var _initialPosition = CameraPosition(
    target: LatLng(-22.00698, -47.89676), // SC
    zoom: 13.5,
  );

  MapType current_map_type = MapType.satellite;

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    for (var position in device_coordinates) {
      Marker m = Marker(
          position: position.gps,
          zIndex: position.altitude,
          alpha: 0.75,
          infoWindow: InfoWindow(
              title: "Alt: ${position.altitude.toStringAsFixed(4)}",
              snippet:
                  "(${position.gps.latitude.toStringAsFixed(4)},${position.gps.latitude.toStringAsFixed(4)})"),
          markerId: MarkerId((position.gps.longitude + position.gps.latitude)
              .toString()) // this is problematic;.toStringAsFixed(4) solution use received index
          );
      markers.add(m);
    }
    lines = {
      Polyline(
          polylineId: PolylineId("device_path"),
          consumeTapEvents: false,
          color: Colors.pink,
          width: 2,
          points: device_coordinates.map((e) => e.gps).toList(),
          zIndex: 1),
      Polyline(
        polylineId: PolylineId("loc_to_device"),
        consumeTapEvents: false,
        color: Colors.blue,
        width: 5,
        points: loc_to_device.map((e) => e.gps).toList(),
        zIndex: 0,
      )
    };

    return new Scaffold(
      body: GoogleMap(
        mapType: current_map_type,
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

  void initState() {
    super.initState();

    widget.mapStreamController.stream.listen((mapType) => _select(mapType));
  }

  void _select(MapType new_map_type) {
    setState(() {
      current_map_type = new_map_type;
    });
  }

  PositionData _generateRandomSC() {
    var r = rng.nextDouble(); // 0.x
    if (rng.nextBool()) r *= r;
    if (rng.nextBool()) r *= -1;
    var lat = -22.000;
    lat += r / 10;
    r = rng.nextDouble();

    if (rng.nextBool()) r *= r;
    if (rng.nextBool()) r *= -1;
    var lng = -47.90;
    lng += r / 10;
    var alt = rng.nextDouble() * rng.nextDouble() * 1000;
    return PositionData(gps: LatLng(lat, lng), altitude: alt);
  }

  Future<void> goHome() async {
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

  Future<PositionData> _getLocation() async {
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
      return PositionData(gps: LatLng(-22.00144, -47.93198));
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

  Future<void> setBearingView() async {
    final GoogleMapController controller = await _controller.future;
    print(loc_to_device[0].toString());
    var cp = CameraPosition(
        bearing: _bearing(loc_to_device[0].gps, loc_to_device[1].gps),
        target: loc_to_device[0]
            .gps, //LatLng(loc_to_device[0].latitude, loc_to_device[0].longitude),
        tilt: 70.0,
        zoom: 17);
    controller.animateCamera(CameraUpdate.newCameraPosition(cp));
  }
}

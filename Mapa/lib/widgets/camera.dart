//           // appBar: AppBar(
//         //   title: Text("First Maps"),
//         //   actions: <Widget>[
//         //     PopupMenuButton<ChoiceMapType>(
//         //       tooltip: "Select Map Type",
//         //       icon: Icon(Icons.map),
//         //       onSelected: _select,
//         //       itemBuilder: (BuildContext context) {
//         //         return choices.skip(1).map((ChoiceMapType choice) {
//         //           return PopupMenuItem<ChoiceMapType>(
//         //             value: choice,
//         //             child: Text(choice.name),
//         //           );
//         //         }).toList();
//         //       },
//         //     ),
//         //   ],
//         // ),

//                 // floatingActionButton: Row(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   mainAxisSize: MainAxisSize.max,
//         //   children: <Widget>[
//         //     Spacer(),
//         //     FloatingActionButton(
//         //       onPressed: _goHome,
//         //       child: Icon(Icons.home),
//         //     ),
//         //     Spacer(),
//         //     FloatingActionButton.extended(
//         //       onPressed: _addNewPoint,
//         //       label: Text('Add'),
//         //       icon: Icon(Icons.location_on),
//         //     ),
//         //     Spacer(),
//         //     FloatingActionButton.extended(
//         //       onPressed: _setBearingView,
//         //       label: Text('Point to Device'),
//         //       icon: Icon(Icons.arrow_upward),
//         //     ),
//         //     Spacer(),
//         //   ],
//         // )

//   PositionData _generateRandomSC() {
//     var r = rng.nextDouble(); // 0.x
//     if (rng.nextBool()) r *= r;
//     if (rng.nextBool()) r *= -1;
//     var lat = -22.000;
//     lat += r / 10;
//     r = rng.nextDouble();

//     if (rng.nextBool()) r *= r;
//     if (rng.nextBool()) r *= -1;
//     var lng = -47.90;
//     lng += r / 10;
//     var alt = rng.nextDouble() * rng.nextDouble() * 1000;
//     return PositionData(gps: LatLng(lat, lng), altitude: alt);
//   }

//   Future<void> _goHome() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
//   }

//   void _addNewPoint() {
//     setState(() {
//       var point = _generateRandomSC();
//       device_coordinates.add(point);
//       loc_to_device[1] = point;
//     });
//   }

//   Future<PositionData> _getLocation() async {
//     // Location location = new Location();
//     // bool _serviceEnabled;
//     // PermissionStatus _permissionGranted;
//     // LocationData _locationData;

//     // _serviceEnabled = await location.serviceEnabled();
//     // if (!_serviceEnabled) {
//     //   _serviceEnabled = await location.requestService();
//     //   if (!_serviceEnabled) {
//     //     print('permission error');
//     //   }
//     // }

//     // _permissionGranted = await location.hasPermission();
//     // if (_permissionGranted == PermissionStatus.denied) {
//     //   _permissionGranted = await location.requestPermission();
//     //   if (_permissionGranted != PermissionStatus.granted) {
//     //     print('permission error');
//     //   }
//     // }

//     // _locationData = await location.getLocation();
//     // return LatLng(_locationData.latitude,_locationData.longitude);
//     return Future.delayed(Duration(seconds: 1), () {
//       return PositionData(gps: LatLng(-22.9034, -43.2655));
//     });
//   }

//   double _radians(double degrees) {
//     return degrees * (pi / 180);
//   }

//   double _bearing(LatLng p1, LatLng p2) {
//     var lat1 = _radians(p1.latitude);
//     var lat2 = _radians(p2.latitude);
//     var long1 = _radians(p1.longitude);
//     var long2 = _radians(p2.longitude);
//     var y = sin(long2 - long1) * cos(lat2);
//     var x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(long2 - long1);
//     var theta = atan2(y, x);
//     return (theta * 180 / pi + 360) % 360; // in degrees
//   }

//   Future<void> _setBearingView() async {
//     final GoogleMapController controller = await _controller.future;
//     print(loc_to_device[0].toString());
//     var cp = CameraPosition(
//         bearing: _bearing(loc_to_device[0].gps, loc_to_device[1].gps),
//         target: loc_to_device[0]
//             .gps, //LatLng(loc_to_device[0].latitude, loc_to_device[0].longitude),
//         tilt: 70.0,
//         zoom: 17);
//     controller.animateCamera(CameraUpdate.newCameraPosition(cp));
//   }
// }

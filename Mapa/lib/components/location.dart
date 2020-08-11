import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationManager {
  final Location _location = new Location();

  StreamController<int> _statusCtrl = StreamController();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  LocationManager() {
    _serviceEnabled = false;
    _permissionGranted = PermissionStatus.denied;
    _statusCtrl.add(0);
  }

  Future<void> init() async {
    print('initiating location');
    if (!_serviceEnabled) {
      await _enable();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      await _permission();
    }
    _location.changeSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 50.0);
  }

  bool check() {
    return (_serviceEnabled && _permissionGranted == PermissionStatus.granted);
  }

  Future<bool> _enable() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        print('service error');
        _statusCtrl.add(-1);
      } else {
        print("Location Service is Enabled!");
        _statusCtrl.add(1);
      }
    }
  }

  Future<bool> _permission() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('permission error');
        _statusCtrl.add(-2);
      } else if (_permissionGranted == PermissionStatus.granted) {
        print("Got permission!");
        _statusCtrl.add(2);
      }
    }
  }

  Stream<LatLng> receive() {
    if (check()) {
      return _location.onLocationChanged.asyncMap((LocationData event) {
        print(event);
        return LatLng(event.latitude, event.longitude);
      });
    } else {
      return Stream.empty();
    }
  }

  Stream<int> status() {
    return _statusCtrl.stream;
  }

  @override
  void dispose() {
    _statusCtrl.close();
  }
}

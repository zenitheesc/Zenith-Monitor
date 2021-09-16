import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationManager {
  late final Location _location = new Location();
  late StreamController<int> _statusCtrl = StreamController();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  LocationManager() {
    _serviceEnabled = false;
    _permissionGranted = PermissionStatus.denied;
    _statusCtrl.add(0);
  }

  Future<LocationData> init() async {
    if (!_serviceEnabled) {
      await _enable();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      await _permission();
    }
    _location.changeSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 50);

    LocationData data = await _location.getLocation();

    _location.onLocationChanged.listen((event) {
      printVariables(event);
    });

    receive();
    return data;
  }

  void printVariables(LocationData data) {
    print('latitude: ${data.latitude!}');
    print('longitude: ${data.longitude!}');
    print('accuracy: ${data.accuracy!}');
    print('altitude: ${data.altitude!}');
    print('speed: ${data.speed!}');
    print('speedAccuracy: ${data.speedAccuracy!}');
    print('heading: ${data.heading!}');
    print('time: ${data.time!}');
    print('isMock: ${data.isMock!}');
  }

  bool check() {
    return (_serviceEnabled && _permissionGranted == PermissionStatus.granted);
  }

  Future<void> _enable() async {
    _serviceEnabled = await _location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        print('service error');
        _statusCtrl.add(-1);
      } else {
        print("location service is Enabled!");
        _statusCtrl.add(1);
      }
    }
  }

  Future<void> _permission() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('permission error!');
        _statusCtrl.add(-2);
      } else if (_permissionGranted == PermissionStatus.granted) {
        print("permission granted!");
        _statusCtrl.add(2);
      }
    }
  }

  Stream<LatLng> receive() {
    if (check()) {
      print("receiving...");
      return _location.onLocationChanged.asyncMap((LocationData event) {
        return LatLng(event.latitude!, event.longitude!);
      });
    } else {
      return Stream.empty();
    }
  }

  Stream<int> status() {
    return _statusCtrl.stream;
  }

  void dispose() {
    _statusCtrl.close();
  }
}

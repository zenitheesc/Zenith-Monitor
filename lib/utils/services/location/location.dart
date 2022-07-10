import 'dart:async';
import 'package:location/location.dart';

class LocationManager {
  final Location _location = Location();
  final StreamController<int> _statusCtrl = StreamController();
  final StreamController<LocationData> _locationController = StreamController();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  LocationManager() {
    _serviceEnabled = false;
    _permissionGranted = PermissionStatus.denied;
    _statusCtrl.add(0);
  }

  Future<void> init() async {
    if (!_serviceEnabled) {
      await _enable();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      await _permission();
    }
    _location.changeSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 50);

    _location.onLocationChanged.listen((event) {
      _locationController.add(event);
    });
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

  Stream<int> status() {
    return _statusCtrl.stream;
  }

  Stream<LocationData> locationStream() {
    return _locationController.stream;
  }

  void dispose() {
    _locationController.close();
    _statusCtrl.close();
  }
}

import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/models/target_trajectory.dart';

class UsbManager {
  final rng = Random();
  var _statusStream = StreamController<int>();

  Future<void> init() async {
    // if ok
    await Future.delayed(Duration(milliseconds: 10), () {});
    _statusStream.add(1);
  }

  Stream<TargetTrajectory> receive() {
    _statusStream.add(2);
    return Stream.periodic(Duration(seconds: 1), (int count) {
      return _generateRandomSC(count);
    }).take(12);
  }

  TargetTrajectory _generateRandomSC(int id) {
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
    var spd = rng.nextDouble() * rng.nextDouble() * 100;
    _statusStream.add(10);
    return TargetTrajectory(
      position: LatLng(lat, lng),
      altitude: alt,
      id: id,
      speed: spd,
    );
  }

  Stream<int> status() {
    _statusStream.add(0);
    return _statusStream.stream;
  }

  void dispose() {
    _statusStream.close();
  }
}

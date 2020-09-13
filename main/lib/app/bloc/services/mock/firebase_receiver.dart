import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/models/target_trajectory.dart';

class FirebaseReceiver {
  final rng = Random();
  var _statusStream = StreamController<int>();

  Stream<int> status() {
    return _statusStream.stream;
  }

  Future<void> init() async {
    // if ok
    await Future.delayed(Duration(milliseconds: 20), () {});
    print('initating follower');
    _statusStream.add(1);
  }

  TargetTrajectory _generateRandomRJ(int id) {
    var r = rng.nextDouble(); // 0.x
    if (rng.nextBool()) r *= r;
    if (rng.nextBool()) r *= -1;

    var lat = -22.906;
    lat += r / 10;
    r = rng.nextDouble();

    if (rng.nextBool()) r *= r;
    if (rng.nextBool()) r *= -1;
    var lng = -43.17;
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

  Stream<TargetTrajectory> receive() {
    return Stream.periodic(Duration(seconds: 1), (int count) {
      return _generateRandomRJ(count);
    }).take(12);
  }

  void dispose() {
    _statusStream.close();
  }
}

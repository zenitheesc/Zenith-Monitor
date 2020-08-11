import 'dart:math';

import 'package:firstattemptatmaps/models/target_trajectory.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataManager {
  final rng = Random();
  Stream<TargetTrajectory> receive() {
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

    return TargetTrajectory(position: LatLng(lat, lng), altitude: alt, id: id);
  }
}

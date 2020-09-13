import 'package:google_maps_flutter/google_maps_flutter.dart';

class TargetTrajectory {
  int id = 0;
  LatLng position = LatLng(0, 0);
  double altitude = 0.0;
  double speed = 0.0;

  TargetTrajectory({this.id, this.position, this.altitude, this.speed});

  @override
  String toString() {
    return "Packet: { id: ${this.id};  pos: (${this.position.latitude.toStringAsFixed(4)},${this.position.longitude.toStringAsFixed(4)} }); alt: ${this.altitude.toStringAsFixed(2)};  spd: ${this.speed}; }";
  }
}

// class MapUpdatePacket {
//  TargetTrajectory target_pos;
//  LatLng user_pos;
// }

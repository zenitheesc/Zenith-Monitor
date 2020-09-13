import 'dart:async';

import 'package:zenith_monitor/app/models/target_trajectory.dart';

// MOCK
class FirebaseUploader {
  var _statusStream = StreamController<int>();

  Future<void> save(TargetTrajectory packet) async {
    // crude check if data is comming from FirebaseReceiver
    if (packet.position.longitude > -45.0) {
      print("there will be a loop");
    }
    print("Saving to Firebase (id:${packet.id})");
    await Future.delayed(Duration(milliseconds: 300), () {});
    // handle errors...
    _statusStream.add(10); // some code meaning status OK
  }

  Stream<int> status() {
    _statusStream.add(0); //inital ?
    return _statusStream.stream;
  }
}

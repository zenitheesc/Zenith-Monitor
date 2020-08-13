import 'dart:async';

import 'package:zenith_monitor/app/models/target_trajectory.dart';

class LocalDatabase {
  var _statusStream = StreamController<int>();

  Future<void> save(TargetTrajectory packet) async {
    print("Saving to LocalDatabase (id:${packet.id})");
    await Future.delayed(Duration(milliseconds: 10), () {});
    // handle errors...
    _statusStream.add(10); // some code meaning status OK
  }

  Stream<int> status() {
    _statusStream.add(0); //inital ?
    return _statusStream.stream;
  }
}

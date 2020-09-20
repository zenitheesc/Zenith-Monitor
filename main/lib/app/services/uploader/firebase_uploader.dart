// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:zenith_monitor/app/models/data_packet.dart';

// MOCK
class FirebaseUploader {
  var _statusStream = StreamController<int>();
  CollectionReference _subCollectionReference;

  FirebaseUploader() {
    _subCollectionReference = FirebaseFirestore.instance
        .collection("missoes")
        .doc("test-launch")
        .collection("logs");
  }

  Future<void> save(TargetTrajectory packet) async {
    Map<String, dynamic> data = {
      "lat": packet.position.latitude,
      "lng": packet.position.longitude,
      "alt": packet.altitude,
      "vel": packet.speed,
      "id": packet.id
    };

    // crude check if data is comming from FirebaseReceiver
    if (packet.position.longitude > -45.0) {
      print("there will be a loop");
    }
    print("Saving to Firebase (id:${packet.id})");
    await _subCollectionReference.add(data);

    // handle errors...
    _statusStream.add(10); // some code meaning status OK
  }

  Stream<int> status() {
    _statusStream.add(0); //inital ?
    return _statusStream.stream;
  }
}

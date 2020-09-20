import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/models/data_packet.dart';

class FirebaseReceiver {
  var _statusStream = StreamController<int>();
  CollectionReference _subCollectionReference;
  var _dataStream = StreamController<TargetTrajectory>();

  Future<void> init() async {
    _statusStream.add(1);
    _subCollectionReference = FirebaseFirestore.instance
        .collection("missoes")
        .doc("test-launch")
        .collection("logs");

    _statusStream.add(1);

    var qSnap = await _subCollectionReference.orderBy("id").get();
    if (qSnap.docs.length > 1) {
      qSnap.docs
          .getRange(0, qSnap.docs.length - 1)
          .forEach((DocumentSnapshot doc) {
        _dataStream.add(parser(doc));
      });
    }

    _statusStream.add(2);

    _subCollectionReference
        .orderBy("id")
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      if (event.docs.length > 0) {
        TargetTrajectory packet = parser(event.docs.last);
        _dataStream.add(packet);
      }
    });
    _statusStream.add(10);

    // Firestore.instance
  }

  TargetTrajectory parser(DocumentSnapshot doc) {
    // if(...) //TODO: Check if is valid Packet
    return TargetTrajectory(
      position: LatLng(doc.data()["lat"], doc.data()["lng"]),
      altitude: doc.data()["alt"],
      speed: doc.data()["vel"],
      id: doc.data()["id"],
    );
  }

  Stream<TargetTrajectory> receive() {
    return _dataStream.stream;
  }

  Stream<int> status() {
    return _statusStream.stream;
  }

  void dispose() {
    _statusStream.close();
    _dataStream.close();
  }
}

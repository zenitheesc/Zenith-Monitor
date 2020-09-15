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
    _subCollectionReference = Firestore.instance
        .collection("missoes")
        .document("test-launch")
        .collection("logs");

    _statusStream.add(1);

    var qSnap =
        await _subCollectionReference.orderBy("id").getDocuments(); //? .then
    qSnap.documents
        .getRange(0, qSnap.documents.length - 1)
        .forEach((DocumentSnapshot doc) {
      _dataStream.add(parser(doc));
    });

    _statusStream.add(2);
    //! O ultimo dado vindo da query anterior vai aparecer aqui tbm
    //! então vai pra pipeline duas vezes
    _subCollectionReference.orderBy("id").snapshots().listen((event) {
      TargetTrajectory packet = parser(event.documents.last);
      // if(...)
      return _dataStream.add(packet);
    });
    _statusStream.add(10);
  }

  TargetTrajectory parser(DocumentSnapshot doc) {
    // if(...) //TODO: Check if is valid Packet
    return TargetTrajectory(
      position: LatLng(doc["lat"], doc["lng"]),
      altitude: doc["alt"],
      speed: doc["vel"],
      id: doc["id"],
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

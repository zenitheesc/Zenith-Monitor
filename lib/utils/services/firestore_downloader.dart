import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'dart:async';

import 'package:zenith_monitor/widgets/standard_app_bar.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MissionInformation extends StatelessWidget {
  final CollectionReference _subCollectionReference = FirebaseFirestore.instance
      .collection('missoes')
      .doc('test-launch')
      .collection('logs');

  late final Stream<QuerySnapshot> _dataStream =
      _subCollectionReference.snapshots(includeMetadataChanges: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(title: "Firestore"),
      body: StreamBuilder<QuerySnapshot>(
          stream: _dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Erro ao pegar o documento.",
                    style: TextStyle(color: white)),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: ZenithProgressIndicator(
                    size: 150, fileName: 'z_icon_white.png'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  _buildItemList(context, snapshot.data!.docs[index]),
            );
          }),
      backgroundColor: raisingBlack,
    );
  }

  Widget _buildItemList(
      BuildContext context, QueryDocumentSnapshot<Object?> doc) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ID: ${doc["id"].toString()}\nAltitude: ${doc["alt"].toString()}\nLatitude: ${doc["lat"].toString()}\nLongitude: ${doc["lng"].ceil().toString()}\nVelocidade: ${doc["vel"].toString()}",
              style: const TextStyle(color: white),
            ),
          )
        ],
      ),
    );
  }
}

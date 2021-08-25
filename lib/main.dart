import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:zenith_monitor/utils/services/firestore_related.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Application(),
    );
  }
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Scaffold();
    return MissionInformation();
  }
}

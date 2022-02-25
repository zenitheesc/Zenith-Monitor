import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'modules/last_missions/screen/last_missions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LastMissions());
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';

import 'modules/register/screen/sign_up_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Application(),
    );
  }
}

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Scaffold(backgroundColor: Colors.red);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SignUpScreen();
        }

        return const ZenithProgressIndicator(
            size: 30, fileName: "z_icon_white.png");
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}

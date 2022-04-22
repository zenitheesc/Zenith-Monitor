import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';
import 'modules/login/screen/login_screen.dart';

const bool debugEnableDeviceSimulator = true;
void main() {
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);


  final LocationManager data = LocationManager();

  @override
  Widget build(BuildContext context) {
    data.init();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MissionBloc()),
        ],
        child: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Scaffold(backgroundColor: Colors.red);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return const LoginScreen();
            }

            return const ZenithProgressIndicator(
                size: 30, fileName: "z_icon_white.png");
          },
        ));
  }
}

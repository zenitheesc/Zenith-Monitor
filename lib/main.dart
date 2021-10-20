import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';
import 'package:zenith_monitor/utils/services/authentication/google_auth.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';
import 'modules/login/screen/login_screen.dart';
import 'modules/register/screen/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  ZenithMonitor({Key? key}) : super(key: key);

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
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return const Scaffold(backgroundColor: Colors.red);
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              EmailAndPasswordAuth a = EmailAndPasswordAuth();
              a.signOut();
              GoogleAuth g = GoogleAuth();
              g.signOut();

              return LoginScreen();
            }

            return const ZenithProgressIndicator(
                size: 30, fileName: "z_icon_white.png");
            // Otherwise, show something whilst waiting for initialization to complete
          },
        ));
  }
}

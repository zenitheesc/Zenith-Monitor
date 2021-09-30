import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/configuration/screen/mission_configuration.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreServices _fireServ = FirestoreServices();
  _fireServ.init('testeTimeStamp');
  _fireServ.recive().listen((event) {
    event.getVariablesList().forEach((element) {
      print("${element.getVariableName()}: ${element.getVariableValue()}");
    });
  });
  _fireServ.createRandomDocs("testeTimeStamp", 3);
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
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => MissionBloc()),
    ], child: const MissionConfiguration());
  }
}

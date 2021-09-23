import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/configuration/screen/mission_configuration.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';

import 'package:zenith_monitor/utils/services/firestore_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  final FirestoreServices _fireServ = FirestoreServices();
  await _fireServ.init('test-launch');
  _fireServ.recive().listen((packet) { 
    List _variables = packet.getVariablesList();
    for(var i=0; i<_variables.length; i++) 
    {
      print("Variavel: ${_variables[i].getVariableName()} Value: ${_variables[i].getVariableValue()} Type: ${_variables[i].getVariableType()}\n");
    }
  });

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

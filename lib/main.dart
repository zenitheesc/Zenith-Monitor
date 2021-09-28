import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/bloc/data_bloc.dart';
import 'package:zenith_monitor/modules/configuration/screen/mission_configuration.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';

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
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => MissionBloc()),
      BlocProvider(create: (context) => DataBloc('test-launch')),
    ], child: const MissionConfiguration());
  }
}

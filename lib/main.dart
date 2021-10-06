import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';
import 'package:zenith_monitor/modules/configuration/screen/mission_configuration.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';

void main() {
  runApp(ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  ZenithMonitor({Key? key}) : super(key: key);

  final LocationManager data = LocationManager();
  @override
  Widget build(BuildContext context) {
    data.init();
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
    ], child: Scaffold());
  }
}

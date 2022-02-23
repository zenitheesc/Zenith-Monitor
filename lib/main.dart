import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/configuration/screen/mission_configuration.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';
import 'package:zenith_monitor/modules/forget_password/screen/forgot_my_password_screen.dart';

void main() {
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
    ], child: const ForgotMyPassword());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/pipelines/mission_pipeline/mission_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';
import 'package:zenith_monitor/widgets/mission_creation.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/variables_bloc.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MissionBloc()),
          BlocProvider(
              create: (context) => VariablesBloc(
                    MissionVariablesList(),
                    BlocProvider.of<MissionBloc>(context),
                  ))
        ],
        child: Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                MissionCreation(),
              ],
            ),
          ),
          backgroundColor: eerieBlack,
        ));
  }
}

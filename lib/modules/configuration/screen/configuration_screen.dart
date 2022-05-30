import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/widgets/connections.dart';
import 'package:zenith_monitor/widgets/mission_creation.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';
import 'package:zenith_monitor/widgets/user_profile.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MissionVariablesBloc(
                  MissionVariablesList(),
                  BlocProvider.of<MissionBloc>(context),
                ))
      ],
      child: Scaffold(
        backgroundColor: raisingBlack,
        appBar: const StandardAppBar(title: "Configurações"),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  const UserProfile(),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: eerieBlack,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: const Text(
                              'Criação de Missão',
                              style: TextStyle(color: gray, fontSize: 12.0),
                            )),
                        ConnectionDisplay(connections: [
                          Connection("carlos", true),
                          Connection("carlos", false),
                          Connection("carlos", true),
                          Connection("carlos", true)
                        ]),
                        const SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: const Text(
                              'Criação de Missão',
                              style: TextStyle(color: gray, fontSize: 12.0),
                            )),
                        const MissionCreation(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

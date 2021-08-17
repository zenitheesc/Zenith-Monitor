import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/variables_bloc.dart';
import 'package:zenith_monitor/pipelines/mission_pipeline/mission_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';
import 'package:zenith_monitor/widgets/mission_creation.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class Configuration extends StatelessWidget {
  const Configuration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => VariablesBloc(
                  MissionVariablesList(),
                  BlocProvider.of<MissionBloc>(context),
                ))
      ],
      child: Scaffold(
        backgroundColor: raisingBlack,
        appBar: StandardAppBar(title: "Configurações"),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: eerieBlack,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    MissionCreation(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

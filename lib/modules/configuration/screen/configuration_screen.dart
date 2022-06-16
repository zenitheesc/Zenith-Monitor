import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/connections.dart';
import 'package:zenith_monitor/widgets/dropdown_list.dart';
import 'package:zenith_monitor/widgets/mission_creation.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';
import 'package:zenith_monitor/widgets/user_profile.dart';

class ConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MissionVariablesBloc(
                  MissionVariablesList(),
                  BlocProvider.of<DataBloc>(context),
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
                        sectionsTitle("Conexões"),
                        ConnectionDisplay(connections: [
                          Connection("carlos", true),
                          Connection("carlos", false),
                          Connection("carlos", true),
                          Connection("carlos", true)
                        ]),
                        sectionsTitle('Criação de Missão'),
                        const MissionCreation(),
                        sectionsTitle('Seleção de Missão'),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.83,
                              child: missionSelection(),
                            ),
                          ),
                        ),
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

  Widget missionSelection() {
    return FutureBuilder<List<String>>(
        future: FirestoreServices().getMissionNames(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          List<String> missionNames;
          Widget finalWidget = const ZenithProgressIndicator(
              size: 20, fileName: "z_icon_white.png");
          if (snapshot.hasData && snapshot.data != null) {
            missionNames = snapshot.data!;
            missionNames.add("Nenhuma");

            finalWidget = DropdownList(
              itemsList: missionNames,
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<DataBloc>(context)
                      .add(SettingMissionName(missionName: value));
                }
              },
            );
          }
          return finalWidget;
        });
  }

  Align sectionsTitle(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 20.0, bottom: 20.0),
        child: Text(
          title,
          style: const TextStyle(color: gray, fontSize: 12.0),
        ),
      ),
    );
  }
}

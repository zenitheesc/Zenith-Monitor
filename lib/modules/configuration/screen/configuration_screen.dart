import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_connection.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/configuration_bluetooth_devices.dart';
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
            SliverToBoxAdapter(
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
                        BlocBuilder<MissionVariablesBloc,
                            MissionVariablesState>(
                          buildWhen: (previous, current) =>
                              previous != current &&
                              current is NewConnectionsState,
                          builder: (context, state) {
                            if (state is NewConnectionsState) {
                              return ConnectionDisplay(connections: [
                                for (MapEntry e in state.connections.entries)
                                  Connection(e.key, e.value)
                              ]);
                            } else {
                              Map<String, bool> c = context.select(
                                  (MissionVariablesBloc bloc) =>
                                      bloc.connections);
                              return FutureBuilder<ConnectivityResult>(
                                  future: Connectivity().checkConnectivity(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<ConnectivityResult>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      c["Internet"] = (snapshot.data ==
                                              ConnectivityResult.none)
                                          ? false
                                          : true;
                                    }
                                    return ConnectionDisplay(connections: [
                                      for (MapEntry e in c.entries)
                                        Connection(e.key, e.value)
                                    ]);
                                  });
                            }
                          },
                        ),
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
    return FutureBuilder<Set<String>>(
        future: FirestoreServices().getMissionNames(),
        builder: (BuildContext context, AsyncSnapshot<Set<String>> snapshot) {
          Set<String> missionNames;
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

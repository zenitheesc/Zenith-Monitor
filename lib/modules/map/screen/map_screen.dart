import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/modules/map/bloc/map_bloc.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/dropdown_list.dart';
import 'package:zenith_monitor/widgets/map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () => missionSelection(context));

    return BlocProvider(
      create: (context) => MapBloc(BlocProvider.of<DataBloc>(context)),
      child: MapWidget(),
    );
  }

  void missionSelection(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Selecao de missao",
                  style: TextStyle(color: white)),
              content: const Text(
                  "O seu aplicativo nao esta acompanhando nenhuma missao, selecione dentre as missoes que estao ocorrendo qual voce deseja acompanhar. Caso voce queria criar uma missao ou nao quer acompanhar nenhuma missao, basta deixar a opcao selecionada com 'Nenhuma'.",
                  style: TextStyle(color: white)),
              backgroundColor: black.withOpacity(1),
              actions: <Widget>[
                FutureBuilder<Set<String>>(
                    future: FirestoreServices().getMissionNames(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Set<String>> snapshot) {
                      Set<String> missionNames = <String>{};
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
                    }),
              ],
            ));
  }
}

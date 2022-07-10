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
    String missionName = context.select((DataBloc bloc) => bloc.missionName);
    if (missionName == "Nenhuma") {
      Future.delayed(
          const Duration(seconds: 2),
          () => errorMessage(
                  context,
                  "Seleção de missão",
                  "Seu aplicativo não está rastreando nenhuma missão, selecione dentre as missões que estão ocorrendo qual você deseja rastrear. Se você quer criar uma missão ou não quer acompanhar nenhuma, basta deixar a opção marcada com 'Nenhuma'.",
                  [
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
                                  BlocProvider.of<DataBloc>(context).add(
                                      SettingMissionName(missionName: value));
                                }
                              },
                            );
                          }
                          return finalWidget;
                        }),
                  ]));
    }

    return BlocProvider(
      create: (context) => MapBloc(BlocProvider.of<DataBloc>(context)),
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            errorMessage(context, "Erro", state.errorMessage, [
              TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/configuration'),
                  child: const Text(
                    "Configurações",
                    style: TextStyle(color: white),
                  )),
            ]);
          }
        },
        child: MapWidget(),
      ),
    );
  }

  void errorMessage(BuildContext context, String title, String errorMessage,
      List<Widget> actions) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title, style: const TextStyle(color: white)),
              content: Text(errorMessage, style: const TextStyle(color: white)),
              backgroundColor: black.withOpacity(1),
              actions: actions,
            ));
  }
}

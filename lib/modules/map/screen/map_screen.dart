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
          const Duration(seconds: 2), () => missionSelection(context));
    }

    return BlocProvider(
      create: (context) => MapBloc(BlocProvider.of<DataBloc>(context)),
      child: MapWidget(),
    );
  }

  void missionSelection(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Seleção de missão",
                  style: TextStyle(color: white)),
              content: const Text(
                  "Seu aplicativo não está rastreando nenhuma missão, selecione dentre as missões que estão ocorrendo qual você deseja rastrear. Se você quer criar uma missão ou não quer acompanhar nenhuma, basta deixar a opção marcada com 'Nenhuma'.",
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

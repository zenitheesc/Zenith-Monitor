import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/core/pipelines/map_data_pipeline/map_data_bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:bloc/bloc.dart';
part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  DataBloc dataBloc;
  MapDataBloc mapDataBloc;

  MapBloc({required this.dataBloc, required this.mapDataBloc})
      : super(MapInitialState()) {
    mapDataBloc.stream.listen((event) {});

    dataBloc.stream.listen((state) {
      if (state is NewPackageParsedData) {
        add(NewPackageEvent(newPackage: state.newPackage));
      } else if (state is UsbPackageNotDefined) {
        add(UsbError());
      }
    });
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is NewPackageEvent) {
      List variablesList = event.newPackage.getVariablesList();
      variablesList.removeAt(0);

      /// Removes the timestamp variable
      yield NewPackageState(newVariablesList: variablesList);
    } else if (event is UsbError) {
      yield MapError(
          errorMessage:
              "O dispositivo USB foi conectado, mas ainda não há modelo de pacote para o parser. Se novos pacotes chegarem, eles serão ignorados e perdidos. Para resolver isso, navegue até a página de configurações e escolha uma missão ou crie uma nova.");
    }
  }
}

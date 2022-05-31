import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:bloc/bloc.dart';
part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  DataBloc dataBloc;
  MapBloc(this.dataBloc) : super(MapInitialState()) {
    dataBloc.stream.listen((state) {
      if (state is NewPackageParsedData) {
        add(NewPackageEvent(newPackage: state.newPackage));
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
    }
  }
}

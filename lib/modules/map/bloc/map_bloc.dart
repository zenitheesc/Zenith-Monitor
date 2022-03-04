import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:bloc/bloc.dart';
part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitialState());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is UserInfoEvent) {
      yield UserInfoState(newPackage: event.newPackage);
    }
  }
}

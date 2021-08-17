import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';

part 'mission_state.dart';
part 'mission_event.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  late MissionVariablesList variablesList;

  MissionBloc() : super(MissionStateInitial());

  @override
  Stream<MissionState> mapEventToState(MissionEvent event) async* {
    if (event is SetVariablesListEvent) {
      this.variablesList = event.variablesList;
    } else {
      print("Unknown event in Mission Bloc");
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';

part 'mission_state.dart';
part 'mission_event.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  late MissionVariablesList variablesList;
  late String missionName;

  MissionBloc() : super(MissionStateInitial());

  @override
  Stream<MissionState> mapEventToState(MissionEvent event) async* {
    if (event is SetVariablesListEvent) {
      variablesList = event.variablesList;
      missionName = event.missionName;
      print(missionName);
    } else {
      print("Unknown event in Mission Bloc");
    }
  }
}

/// This pipeline is still incomplete. So far, its is only being used
/// to get the variable list from mission_creation widget. Delete these
/// comments if you are adding more content to this bloc. 
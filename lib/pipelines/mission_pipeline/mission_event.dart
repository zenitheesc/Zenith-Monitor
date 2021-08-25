part of 'mission_bloc.dart';

abstract class MissionEvent {}

class SetVariablesListEvent extends MissionEvent {
  MissionVariablesList variablesList;
  String missionName;

  SetVariablesListEvent(
      {required this.variablesList, required this.missionName});
}

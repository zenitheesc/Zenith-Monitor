part of 'mission_variables_bloc.dart';

abstract class MissionVariablesEvent {}

class AddStandardVariableEvent extends MissionVariablesEvent {
  String variableName;
  String variableType;

  AddStandardVariableEvent(
      {required this.variableName, required this.variableType});
}

class DeleteVariable extends MissionVariablesEvent {
  int variableIndex;

  DeleteVariable({required this.variableIndex});
}

class StartMissionEvent extends MissionVariablesEvent {
  String missionName;

  StartMissionEvent({required this.missionName});
}

class ConnectionChanged extends MissionVariablesEvent {}

part of 'mission_variables_bloc.dart';

abstract class VariablesEvent {}

class AddStandardVariableEvent extends VariablesEvent {
  String variableName;
  String variableType;

  AddStandardVariableEvent(
      {required this.variableName, required this.variableType});
}

class DeleteVariable extends VariablesEvent {
  int variableIndex;

  DeleteVariable({required this.variableIndex});
}

class StartMissionEvent extends VariablesEvent {
  String missionName;

  StartMissionEvent({required this.missionName});
}

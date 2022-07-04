part of 'mission_variables_bloc.dart';

abstract class MissionVariablesState {
  late MissionVariablesList variablesList;

  void setVariablesList(MissionVariablesList variablesList) {
    this.variablesList = variablesList;
  }
}

class VariablesInitial extends MissionVariablesState {
  VariablesInitial(MissionVariablesList variablesList) {
    setVariablesList(variablesList);
  }
}

class VariablesChanged extends MissionVariablesState {
  VariablesChanged(MissionVariablesList variablesList) {
    setVariablesList(variablesList);
  }
}

class VariableInteractionError extends MissionVariablesState {
  late String errorMessage;

  VariableInteractionError(
      MissionVariablesList variablesList, this.errorMessage) {
    setVariablesList(variablesList);
  }
}

class MissionNameError extends MissionVariablesState {
  late String errorMessage;

  MissionNameError(MissionVariablesList variablesList, this.errorMessage) {
    setVariablesList(variablesList);
  }
}

class NewConnectionsState extends MissionVariablesState {
  late Map<String, bool> connections;
  NewConnectionsState(MissionVariablesList variablesList, this.connections) {
    setVariablesList(variablesList);
  }
}

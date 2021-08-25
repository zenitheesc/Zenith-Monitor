part of 'variables_bloc.dart';

abstract class VariablesState {
  late MissionVariablesList variablesList;

  void setVariablesList(MissionVariablesList variablesList) {
    this.variablesList = variablesList;
  }
}

class VariablesInitial extends VariablesState {
  VariablesInitial(MissionVariablesList variablesList) {
    setVariablesList(variablesList);
  }
}

class VariablesChanged extends VariablesState {
  VariablesChanged(MissionVariablesList variablesList) {
    setVariablesList(variablesList);
  }
}

class VariableInteractionError extends VariablesState {
  late String errorMessage;

  VariableInteractionError(
      MissionVariablesList variablesList, this.errorMessage) {
    setVariablesList(variablesList);
  }
}

class MissionNameError extends VariablesState {
  String errorMessage;

  MissionNameError({required this.errorMessage});
}

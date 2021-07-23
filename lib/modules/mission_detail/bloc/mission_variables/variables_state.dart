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

class VariablesAdded extends VariablesState {
  VariablesAdded(MissionVariablesList variablesList) {
    setVariablesList(variablesList);
  }
}

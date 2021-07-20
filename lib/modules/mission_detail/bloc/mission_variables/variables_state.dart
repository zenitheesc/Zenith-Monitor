part of 'variables_bloc.dart';

abstract class VariablesState {}

class VariablesInitial extends VariablesState {
  MissionVariablesList variablesList;

  VariablesInitial({
    required this.variablesList,
  });
}

class VariablesAdded extends VariablesState {
  MissionVariablesList variablesList;

  VariablesAdded({
    required this.variablesList,
  });
}

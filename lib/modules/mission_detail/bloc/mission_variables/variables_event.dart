part of 'variables_bloc.dart';

abstract class VariablesEvent {}

class AddStandardVariableEvent extends VariablesEvent {
  String variableName;
  String variableType;

  AddStandardVariableEvent(
      {required this.variableName, required this.variableType});
}

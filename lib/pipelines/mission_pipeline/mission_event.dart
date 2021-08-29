part of 'mission_bloc.dart';

abstract class MissionEvent {}

class SetVariablesListEvent extends MissionEvent {
  MissionVariablesList variablesList;

  SetVariablesListEvent({required this.variablesList});
}

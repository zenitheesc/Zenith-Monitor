part of 'mission_variables_bloc.dart';

abstract class MissionVariablesState {}

class VariablesInitial extends MissionVariablesState {}

class VariablesChanged extends MissionVariablesState {}

class VariableInteractionError extends MissionVariablesState {
  late String errorMessage;

  VariableInteractionError(this.errorMessage);
}

class MissionNameError extends MissionVariablesState {
  late String errorMessage;

  MissionNameError(this.errorMessage);
}

class NewConnectionsState extends MissionVariablesState {
  late Map<String, bool> connections;
  NewConnectionsState(this.connections);
}

class PackageWoLocationVar extends MissionVariablesState {
  String missionName;
  PackageWoLocationVar({required this.missionName});
}

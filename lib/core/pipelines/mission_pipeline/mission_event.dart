part of 'mission_bloc.dart';

abstract class MissionEvent {}

class SetVariablesListEvent extends MissionEvent {
  MissionVariablesList variablesList;

  SetVariablesListEvent({required this.variablesList});
}

class FirestoreUploaderEvent extends MissionEvent {
  MissionVariablesList variablesList;

  FirestoreUploaderEvent({required this.variablesList});
}


class FirestoreDownloadEvent extends MissionEvent {
  final String missionName;

  FirestoreDownloadEvent({required this.missionName});
}
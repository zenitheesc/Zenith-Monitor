part of 'data_bloc.dart';

abstract class DataEvent {}

class SetVariablesListEvent extends DataEvent {
  MissionVariablesList variablesList;

  SetVariablesListEvent({required this.variablesList});
}

class FirestoreUploaderEvent extends DataEvent {
  MissionVariablesList variablesList;

  FirestoreUploaderEvent({required this.variablesList});
}

class FirestoreDownloadEvent extends DataEvent {
  final String missionName;

  FirestoreDownloadEvent({required this.missionName});
}
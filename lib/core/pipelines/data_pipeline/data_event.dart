part of 'data_bloc.dart';

abstract class DataEvent {}

class MissionInfoSetup extends DataEvent {
  MissionVariablesList packageModel;
  String missionName;

  MissionInfoSetup({required this.missionName, required this.packageModel});
}

class FirestoreDownloadEvent extends DataEvent {
  final String missionName;

  FirestoreDownloadEvent({required this.missionName});
}

class NewRawDataEvent extends DataEvent {
  final String noParsedString;

  NewRawDataEvent({required this.noParsedString});
}

class NewParsedDataEvent extends DataEvent {
  final MissionVariablesList newPackage;

  NewParsedDataEvent({required this.newPackage});
}

class UsbConnected extends DataEvent {}

class UsbDisconnected extends DataEvent {}

class UsbCommand extends DataEvent {
  String command;
  UsbCommand({required this.command});
}

class SettingMissionName extends DataEvent {
  String missionName;
  SettingMissionName({required this.missionName});
}

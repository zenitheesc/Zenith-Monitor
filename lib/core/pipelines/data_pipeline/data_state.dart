part of 'data_bloc.dart';

abstract class DataState {}

class DataStateInitial extends DataState {}

class NewPackageRawData extends DataState {
  final String noParsedString;

  NewPackageRawData({required this.noParsedString});
}

class NewPackageParsedData extends DataState {
  final MissionVariablesList newPackage;

  NewPackageParsedData({required this.newPackage});
}

class UsbConnectedState extends DataState {}

class UsbDisconnectedState extends DataState {}

class NewMissionNameValue extends DataState {
  String missionName;
  Set<String> missionsNames;
  NewMissionNameValue({required this.missionName, required this.missionsNames});
}

class UsbPackageNotDefined extends DataState {}

class BluetoothConnectedState extends DataState {
  final String name;
  final double rssi;

  BluetoothConnectedState(this.name, this.rssi);
}
class BluetoothDisconnectedState extends DataState {}

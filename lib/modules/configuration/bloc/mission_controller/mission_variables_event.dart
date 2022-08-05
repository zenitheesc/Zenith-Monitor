part of 'mission_variables_bloc.dart';

abstract class MissionVariablesEvent {}

class AddStandardVariableEvent extends MissionVariablesEvent {
  String variableName;
  String variableType;

  AddStandardVariableEvent(
      {required this.variableName, required this.variableType});
}

class TableGesture extends MissionVariablesEvent {
  int index;
  TableGesture({required this.index});
}

class DeleteVariable extends TableGesture {
  DeleteVariable(int index) : super(index: index);
}

class ConnectToDevice extends TableGesture {
  ConnectToDevice(int index) : super(index: index);
}

class StartMissionEvent extends MissionVariablesEvent {
  String missionName;
  bool ignoreLocationVar;

  StartMissionEvent(
      {required this.missionName, required this.ignoreLocationVar});
}

class ConnectionChanged extends MissionVariablesEvent {}

class SearchBluetoothDevices extends MissionVariablesEvent {}

class BluetoothDeviceDiscovered extends MissionVariablesEvent {}

class DiscoveryFinished extends MissionVariablesEvent {}

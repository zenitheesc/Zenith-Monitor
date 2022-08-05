part of 'mission_variables_bloc.dart';

abstract class MissionVariablesState {}

class VariablesInitial extends MissionVariablesState {}

class TableUpdate extends MissionVariablesState {
  Map<String, String>? map;
  //TableUpdate({required this.map});
}

class VariablesChanged extends TableUpdate {
  MissionVariablesList missionVariablesList;
  VariablesChanged({required this.missionVariablesList}) {
    map = {};
    List<MissionVariable> list = missionVariablesList.getVariablesList();
    for (int i = 1; i < list.length; i++) {
      map![list[i].getVariableName()] = list[i].getVariableType();
    }
  }
}

class NewBluetoothDevices extends TableUpdate {
  Iterable<BluetoothDevice> bluetoothDevices;
  NewBluetoothDevices({required this.bluetoothDevices}) {
    map = {};
    for (BluetoothDevice device in bluetoothDevices) {
      map!.addAll({
        device.name ?? device.address:
            device.isConnected ? "Conectado" : "Desconectado"
      });
    }
  }
}

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

class DiscoveringBluetoothDevices extends MissionVariablesState {}

class BluetoothDiscoveryFinished extends MissionVariablesState {}

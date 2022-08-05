import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';

class Bluetooth {
  final StreamController<MissionVariablesList> _parsedData =
      StreamController<MissionVariablesList>.broadcast();
  final StreamController<String> _rawData =
      StreamController<String>.broadcast();

  final StreamController<bool> _connected = StreamController<bool>.broadcast();

  final FlutterBluetoothSerial flutterBluetoothSerial =
      FlutterBluetoothSerial.instance;

  Future<List<BluetoothDevice>> getDevices() async {
    return await flutterBluetoothSerial.getBondedDevices();
  }

  Stream<BluetoothDiscoveryResult> getDevicesStream() {
    return flutterBluetoothSerial.startDiscovery();
  }

  Stream<MissionVariablesList> parsedData() {
    return _parsedData.stream;
  }

  Stream<String> rawData() {
    return _rawData.stream;
  }

  Stream<bool> connected() {
    return _connected.stream;
  }
}

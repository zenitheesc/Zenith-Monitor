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

  Future<BluetoothConnection?> connectToDevice(BluetoothDevice device) async {
    BluetoothConnection? bluetoothConnection;
    try {
      bluetoothConnection = await BluetoothConnection.toAddress(device.address);
    } catch (e) {
      print("deu um erro na hora de conectar: " + e.toString());
    }
    return bluetoothConnection;
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

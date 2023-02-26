import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';
import 'package:zenith_monitor/utils/services/usb/usb_exceptions.dart';

class Bluetooth {
  final StreamController<MissionVariablesList> _parsedData =
      StreamController<MissionVariablesList>.broadcast();
  final StreamController<String> _rawData =
      StreamController<String>.broadcast();

  final StreamController<bool> _connected = StreamController<bool>.broadcast();

  final FlutterBluetoothSerial flutterBluetoothSerial =
      FlutterBluetoothSerial.instance;

  MissionVariablesList? packageModel;
  String currentDevice = "";
  double currentRSSI = 0.0;

  Bluetooth() {
    _findFirstReceiverDevice();
  }

  /// Duplicated code from the USB service
  void setPackageModel(MissionVariablesList? newPackageModel) {
    packageModel = newPackageModel;
  }

  /// Duplicated code from the USB service
  MissionVariablesList _makePackage(String line) {
    if (packageModel == null) throw PackageModelNotDefined();

    List<String> splitedString = line.split(";");
    List<MissionVariable> packageList = packageModel!.getVariablesList();

    for (int i = 0; i < packageList.length - 1; i++) {
      MissionVariable v = packageList[i + 1];
      if (v.getVariableType() == "Integer") {
        v.addValue(int.tryParse(splitedString[i]));
      } else if (v.getVariableType() == "Double") {
        v.addValue(double.tryParse(splitedString[i]));
      } else if (v.getVariableType() == "String") {
        v.addValue(splitedString[i]);
      } else {
        print("Fazer throw de exception");
      }
    }
    MissionVariablesList newPackage = MissionVariablesList();
    newPackage.setVariablesList(packageList);
    return newPackage;
  }

  /// To keep compatibility with the USB interface, as so to avoid rewriting
  /// the integration with the rest of the app, the Serial Bluetooth interface
  /// *does NOT ask the user to select a device*.
  /// This function does a search for the first device that ends with a name "cantara"
  /// This, of course, requires that all receivers use such naming scheme. Which is not
  /// ideal, but for now, will do.
  Future<bool> _findFirstReceiverDevice() async {
    BluetoothDiscoveryResult dev = BluetoothDiscoveryResult(
        device: const BluetoothDevice(name: null, address: ""));
    _connected.add(false);
    // The first Discovery doesn't work most times, so we try 5 times. Usually it works on the
    // 2nd or 3rd try
    for (int i = 0; i < 5; ++i) {
      print("Starting Bluetooth Discovery");
      List<BluetoothDiscoveryResult> results =
          await flutterBluetoothSerial.startDiscovery().toList();
      if (results.isEmpty) {
        continue; // Go ahead to the next attempt
      }

      try {
        dev = results.firstWhere((element) {
          // We suppose the naming scheme, so we can assume that there should be
          // a name
          if (element.device.name == null) {
            return false;
          }
          // Satisfy null case
          String devName = element.device.name ?? "";
          // Alcantara, GreenCantara, BlueCantara etc..
          return devName.toLowerCase().endsWith("cantara");
        });
      } on StateError {
        print("No receivers found on this attempt");
        continue;
      }

      break;
    }

    if (dev.device.name == null) {
      print("No receivers found after 5 attempts!!");
      _connected.add(false);
      return false;
    }

    print("Found device: '${dev.device.name}'");
    currentDevice = dev.device.name.toString();
    currentRSSI = dev.rssi.toDouble();
    BluetoothConnection bluetoothConnection =
        await BluetoothConnection.toAddress(dev.device.address);
    
    bluetoothConnection.input?.listen((Uint8List raw) {
      // Catch weird case of BluetoothSerial sending an empty newline,
      // even though its not in the packet sent by the receiver
      if (raw.length <= 2) {
        return;
      }

      String line = ascii.decode(raw);
      print("Got a packet: '$line'");
      _rawData.add(line);

      // Only parse data if there is a PacketModel set that can decode it.
      if (packageModel != null) {
        MissionVariablesList data = _makePackage(line);
        _parsedData.add(data);
      }
    }, onDone: (() {
      _connected.add(false);
    }));
    _connected.add(true);
    return bluetoothConnection.isConnected;
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

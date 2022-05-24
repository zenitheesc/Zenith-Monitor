import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:usb_serial/usb_serial.dart';
import 'package:usb_serial/transaction.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';

//##### adb connect 192.168.99.101:5555 #####//

class UsbManager {
  UsbPort? _port;
  List<MissionVariablesList> _serialData = [];
  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  final StreamController<MissionVariablesList> _parsedData =
      StreamController<MissionVariablesList>.broadcast();
  final StreamController<String> _rawData =
      StreamController<String>.broadcast();
  final StreamController<int> _status = StreamController<int>.broadcast();
  final StreamController<bool> _attatched = StreamController<bool>.broadcast();
  MissionVariablesList packageModel;

  UsbManager({required this.packageModel}) {
    if (UsbSerial.usbEventStream == null) {
      print("UsbSerial.usbEventStream é null");
      return;
    }
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      if (event.event == UsbEvent.ACTION_USB_ATTACHED) {
        _getPorts();
        _attatched.add(true);
      }
      if (event.event == UsbEvent.ACTION_USB_DETACHED) {
        _connectTo(null);
        _status.add(0);
        _attatched.add(false);
      }
    });

    _getPorts();
    _status.add(0);
  }

  MissionVariablesList makePackage(String line) {
    List<String> splitedString = line.split(";");

    List<MissionVariable> packageList = packageModel.getVariablesList();

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

  Future<bool> _connectTo(device) async {
    _serialData.clear();

    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction!.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port!.close();
      _port = null;
    }

    if (device == null) {
      return true;
    }

    _port = await device.create();

    if (await (_port!.open()) != true) {
      return false;
    }

    _status.add(1);

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

    _subscription = _transaction!.stream.listen((String line) {
      _rawData.add(line);
      MissionVariablesList data = makePackage(line);

      _parsedData.add(data);
      /*_serialData.add(data);

      if (_serialData.length > 20) {
        _serialData.removeAt(0);
      }
      dados.add(data);*/
    });

    return true;
  }

  Future<void> _getPorts() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();

    devices.forEach((device) async {
      if (device.vid == 6790 && device.pid == 29987) {
        await _connectTo(device);
      }
    });
    if (devices.isNotEmpty) await _connectTo(devices[0]);
  }

  Stream<int> status() {
    return _status.stream;
  }

  Stream<bool> attached() {
    return _attatched.stream;
  }

  Stream<MissionVariablesList> parsedData() {
    return _parsedData.stream;
  }

  Stream<String> rawData() {
    return _rawData.stream;
  }
}

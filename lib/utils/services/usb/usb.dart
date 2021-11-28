import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:usb_serial/usb_serial.dart';
import 'package:usb_serial/transaction.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';

//##### adb connect 192.168.99.101:5555 #####//

class UsbManager {
  UsbPort? _port;
  List<MissionVariablesList> _serialData = [];
  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  StreamController<MissionVariablesList> dados =
      StreamController<MissionVariablesList>.broadcast();
  final StreamController<int> _status = StreamController<int>.broadcast();
  final StreamController<bool> _attatched = StreamController<bool>.broadcast();

  MissionVariablesList makePackage(String line) {
    List<String> dados = line.split(";");

    double? alt, vel;
    LatLng? pos;
    int? id;

    /*
    id = int.tryParse(dados.elementAt(0));
    pos = LatLng(double.tryParse(dados.elementAt(1)),
        double.tryParse(dados.elementAt(2)));
    alt = double.tryParse(dados.elementAt(3));
    vel = double.tryParse(dados.elementAt(4));
*/
    return MissionVariablesList();
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
    if (_port == null || !await _port!.open()) {
      return false;
    }

    _status.add(1);

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    if (_port!.inputStream == null) {
      print("_port!.inputStream é null");
      return false;
    }
    _transaction = Transaction.stringTerminated(
        (_port!.inputStream)!, Uint8List.fromList([13, 10]));

    if (_transaction == null) {
      print("_transaction é null");
      return false;
    }

    _subscription = _transaction!.stream.listen((String line) {
      MissionVariablesList data = makePackage(line);
      print(line);

      _serialData.add(data);
      if (_serialData.length > 20) {
        _serialData.removeAt(0);
      }
      dados.add(data);
    });

    return true;
  }

  Future<void> _getPorts() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    print("Devices:");
    print(devices);

    devices.forEach((device) async {
      if (device.vid == 6790 && device.pid == 29987) {
        await _connectTo(device);
      }
    });
  }

  UsbManager() {
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

  Stream<int> status() {
    return _status.stream;
  }

  Stream<bool> attached() {
    return _attatched.stream;
  }

  Stream<MissionVariablesList> receive() {
    return dados.stream;
  }
}

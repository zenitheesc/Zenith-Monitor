import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:usb_serial/usb_serial.dart';
import 'package:usb_serial/transaction.dart';

class UsbManager {
  UsbPort _port;
  List<Widget> _serialData = [];
  StreamSubscription<String> _subscription;
  Transaction<String> _transaction;
  StreamController<String> dados = StreamController<String>.broadcast();
  StreamController<bool> status = StreamController<bool>.broadcast();

  Future<bool> _connectTo(device) async {
    _serialData.clear();

    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port.close();
      _port = null;
    }

    if (device == null) {
      return true;
    }

    _port = await device.create();
    if (!await _port.open()) {
      return false;
    }

    status.add(true);

    await _port.setDTR(true);
    await _port.setRTS(true);
    await _port.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port.inputStream, Uint8List.fromList([13, 10]));

    _subscription = _transaction.stream.listen((String line) {
      _serialData.add(Text(line));
      if (_serialData.length > 20) {
        _serialData.removeAt(0);
      }
      dados.add(line);
    });

    return true;
  }

  Future<void> _getPorts() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    print(devices);

    devices.forEach((device) async {
      if (device.vid == 6790 && device.pid == 29987) {
        await _connectTo(device);
      }
    });
  }

  @override
  UsbManager() {
    UsbSerial.usbEventStream.listen((UsbEvent event) {
      if (event.event == UsbEvent.ACTION_USB_ATTACHED) {
        _getPorts();
      }
      if (event.event == UsbEvent.ACTION_USB_DETACHED) {
        _connectTo(null);
        status.add(false);
      }
    });

    _getPorts();
    status.add(false);
  }
}

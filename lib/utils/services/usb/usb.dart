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
	/*StreamController<MissionVariablesList> dados =
	  StreamController<MissionVariablesList>.broadcast();*/
	StreamController<String> dados = StreamController<String>.broadcast();
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
		List<String> dados = line.split(";");

		/*
		   id = int.tryParse(dados.elementAt(0));
		   pos = LatLng(double.tryParse(dados.elementAt(1)),
		   double.tryParse(dados.elementAt(2)));
		   alt = double.tryParse(dados.elementAt(3));
		   vel = double.tryParse(dados.elementAt(4));
		   */

		MissionVariablesList newPackage = MissionVariablesList();
		newPackage.setVariablesList(packageModel.getVariablesList());
		List<MissionVariable> packageList = newPackage.getVariablesList();

		for (int i = 1; i < packageList.length; i++) {
			MissionVariable v = packageList[i];
			if (v.getVariableType() == "Integer") {
				v.addValue(int.tryParse((dados.elementAt(i - 1))));
			} else if (v.getVariableType() == "Double") {
				v.addValue(double.tryParse((dados.elementAt(i - 1))));
			} else if (v.getVariableType() == "String") {
				v.addValue((dados.elementAt(i - 1)));
			} else {
				print("Fazer throw de exception");
			}
		}
		return newPackage;
	}

	Future<bool> _connectTo(device) async {
		dados.add("chamou o connetTo");
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
		dados.add("passou por toda a galera");
		_port = await device.create();
		if (_port == null || !await _port!.open()) {
			return false;
		}

		_status.add(1);

		await _port!.setDTR(true);
		await _port!.setRTS(true);
		await _port!.setPortParameters(
				9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);
		dados.add("parametros setados");
		if (_port!.inputStream == null) {
			dados.add("_port!.inputStream é null");
			return false;
		}

		_transaction = Transaction.stringTerminated(
				(_port!.inputStream)!, Uint8List.fromList([13, 10]));

		if (_transaction == null) {
			dados.add("_transaction é null");
			return false;
		}
		_port!.inputStream!.listen((Uint8List data) {
			dados.add(data.toString());
		});
		_subscription = _transaction!.stream.listen((String line) {
			// MissionVariablesList data = makePackage(line);
			print(line);

			/*_serialData.add(data);
			  if (_serialData.length > 20) {
			  _serialData.removeAt(0);
			  }
			  dados.add(data);*/
			dados.add(line);
		});

		return true;
	}

	Future<void> _getPorts() async {
		dados.add("chamou o getPorts");
		List<UsbDevice> devices = await UsbSerial.listDevices();
		print("Devices:");
		print(devices);
		dados.add("os devices são: " + devices.toString());
		dados.add("total de " + devices.length.toString());
		/*devices.forEach((device) async {
		  dados.add("device vid: " + device.vid.toString());
		  dados.add("device pid: " + device.pid.toString());
		  if (device.vid == 6790 && device.pid == 29987) {
		  await _connectTo(device);
		  }
		  });*/
		if (devices.isNotEmpty) await _connectTo(devices[0]);
		<<<<<<< Updated upstream
				=======
	}

	Stream<int> funcLoc() async* {
		for (int i = 0; i < 50; i++) {
			await Future.delayed(Duration(seconds: 1));
			yield i;
		}
		>>>>>>> Stashed changes
	}

	Stream<int> funcLoc() async* {
		for (int i = 0; i < 50; i++) {
			await Future.delayed(Duration(seconds: 1));
			yield i;
		}
	}

	Stream<int> status() {
		return _status.stream;
	}

	Stream<bool> attached() {
		return _attatched.stream;
	}

	/*Stream<MissionVariablesList> receive() {
	  return dados.stream;
	  }*/
	Stream<String> receive() {
		return dados.stream;
	}
}

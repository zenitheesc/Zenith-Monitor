import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/bluetooth/bluetooth.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';

part 'data_state.dart';
part 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  MissionVariablesList? packageModel;
  UsbManager usbManager;
  Bluetooth bluetoothManager;
  FirestoreServices fireServices;
  late bool usbIsConnected;
  
 bool btIsConnected = false;
  late String missionName;

  DataBloc({required this.usbManager, required this.fireServices, required this.bluetoothManager})
      : super(DataStateInitial()) {
    missionName = "Nenhuma";
    usbIsConnected = false;

    bluetoothManager.connected().listen((event) {
        btIsConnected = event;
        if(event) {
          add(BluetoothConnected(device: bluetoothManager.currentDevice, rssi: bluetoothManager.currentRSSI ) );
        }else {
          add(BluetoothDisconnected());
        }
    });

    usbManager.attached().listen((event) {
      if (event) {
        usbIsConnected = true;
        if (usbManager.packageModel == null) {
          add(NoUsbPackageModel());
        }
        add(UsbConnected());
      } else {
        usbIsConnected = false;
        add(UsbDisconnected());
      }
    });

    usbManager.parsedData().listen((event) {
      add(NewParsedDataEvent(newPackage: event));
      fireServices.uploadPackage(event, missionName);
    });
    usbManager.rawData().listen((event) {
      add(NewRawDataEvent(noParsedString: event));
    });

    bluetoothManager.parsedData().listen((event) {
      add(NewParsedDataEvent(newPackage: event));
      fireServices.uploadPackage(event, missionName);
    });
    bluetoothManager.rawData().listen((event) {
      add(NewRawDataEvent(noParsedString: event));
    });

    fireServices.recive().listen((event) {
      if (!usbIsConnected) {
        add(NewParsedDataEvent(newPackage: event));
      }
    });
  }

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is MissionInfoSetup) {
      fireServices.createAndUploadMission(
          event.packageModel, event.missionName);

      packageModel = event.packageModel;
      usbManager.setPackageModel(packageModel);
      bluetoothManager.setPackageModel(packageModel);
      add(SettingMissionName(missionName: event.missionName));
    } else if (event is FirestoreDownloadEvent) {
    } else if (event is NewParsedDataEvent) {
      yield NewPackageParsedData(newPackage: event.newPackage);
    } else if (event is NewRawDataEvent) {
      yield NewPackageRawData(noParsedString: event.noParsedString);
    } else if (event is UsbConnected) {
      yield UsbConnectedState();
    } else if (event is UsbDisconnected) {
      yield UsbDisconnectedState();
    } else if (event is BluetoothConnected) {
      yield BluetoothConnectedState(event.device, event.rssi);
    } else if (event is BluetoothDisconnected) {
      yield BluetoothDisconnectedState();
    } else if (event is UsbCommand) {
      usbManager.sendData(event.command);
    } else if (event is SettingMissionName) {
      missionName = event.missionName;
      Set<String> missionsNames = await FirestoreServices().getMissionNames();
      if (missionName != "Nenhuma" && !missionsNames.contains(missionName)) {
//yield o erro
      }
      if (missionName != "Nenhuma") {
        packageModel = await fireServices.getPackageModel(missionName);
        await fireServices.init(missionName);

        usbManager.setPackageModel(packageModel);
        bluetoothManager.setPackageModel(packageModel);

      } else {
        packageModel = null;
        usbManager.setPackageModel(packageModel);
        bluetoothManager.setPackageModel(packageModel);
      }
      yield NewMissionNameValue(
          missionName: missionName, missionsNames: missionsNames);
    } else if (event is NoUsbPackageModel) {
      yield UsbPackageNotDefined();
    } else {
      print("Unknown event in Mission Bloc");
    }
  }
}

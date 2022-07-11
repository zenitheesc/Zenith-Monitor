import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';

part 'data_state.dart';
part 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  MissionVariablesList? packageModel;
  final FirestoreServices fireServices = FirestoreServices();
  UsbManager usbManager;
  late bool usbIsConnected;
  late String missionName;

  DataBloc({required this.usbManager}) : super(DataStateInitial()) {
    missionName = "Nenhuma";
    usbIsConnected = false;

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
      } else {
        packageModel = null;
        usbManager.setPackageModel(packageModel);
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

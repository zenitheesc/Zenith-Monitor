import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';

part 'data_state.dart';
part 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  late MissionVariablesList packageModel;
  final FirestoreServices fireServices = FirestoreServices();
  late UsbManager usbManager;
  late bool usbIsConnected;
  late String missionName;

  DataBloc() : super(DataStateInitial()) {
    missionName = "Nenhuma";
    usbIsConnected = false;

    packageModel = MissionVariablesList();
    packageModel.addStandardVariable("nome", "S");
    packageModel.addStandardVariable("numero inteiro", "I");
    packageModel.addStandardVariable("numero real", "R");

    usbManager = UsbManager(packageModel: packageModel);

    usbManager.parsedData().listen((event) {
      add(NewParsedDataEvent(newPackage: event));
      String fina = "";
      for (MissionVariable varia in event.getVariablesList()) {
        fina += " " + varia.getVariableValue().toString();
      }
      add(NewRawDataEvent(noParsedString: "Como ficou o parser:" + fina));
    });
    usbManager.rawData().listen((event) {
      add(NewRawDataEvent(noParsedString: event));
    });
    usbManager.attached().listen((event) {
      if (event) {
        usbIsConnected = true;
        add(UsbConnected());
      } else {
        usbIsConnected = false;
        add(UsbDisconnected());
      }
    });
  }

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is MissionInfoSetup) {
      fireServices.createAndUploadMission(
          event.packageModel, event.missionName);

      packageModel = event.packageModel;
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
      List<String> missionsNames = await FirestoreServices().getMissionNames();
      yield NewMissionNameValue(
          missionName: missionName, missionsNames: missionsNames);
    } else {
      print("Unknown event in Mission Bloc");
    }
  }
}

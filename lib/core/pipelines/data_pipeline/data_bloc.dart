import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';

part 'data_state.dart';
part 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  late MissionVariablesList packageModel;
  final FirestoreServices fireServices = FirestoreServices();
  late UsbManager usbManager;

  DataBloc() : super(DataStateInitial()) {
    /* usbManager.funcLoc().listen((i) {
      print("Ta chegando no databloc ");

      add(NewPackageEventData(
          noParsedString: i.toString(), newPackage: MissionVariablesList()));
    });*/
    usbManager.receive().listen((event) {
      add(NewPackageEventData(
          noParsedString: event, newPackage: MissionVariablesList()));
    });
    usbManager.attached().listen((event) {
      if (event) {
        add(NewPackageEventData(
            noParsedString: "Ta conectado cachorro",
            newPackage: MissionVariablesList()));
      } else {
        add(NewPackageEventData(
            noParsedString: "Desconectou", newPackage: MissionVariablesList()));
      }
    });
  }

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is SetVariablesListEvent) {
      packageModel = event.variablesList;
      usbManager = UsbManager(packageModel: packageModel);
    } else if (event is FirestoreUploaderEvent) {
      fireServices.createAndUploadMission(event.variablesList);
    } else if (event is FirestoreDownloadEvent) {
    } else if (event is NewPackageEventData) {
      //provavelmente não vai ser assim posteriormente, isso serve mais para testar o terminalBloc
      yield NewPackageStateData(
          noParsedString: event.noParsedString, newPackage: event.newPackage);
    } else {
      print("Unknown event in Mission Bloc");
    }
  }
}

/// This pipeline is still incomplete. So far, its is only being used
/// to get the variable list from mission_creation widget. Delete these
/// comments if you are adding more content to this bloc.

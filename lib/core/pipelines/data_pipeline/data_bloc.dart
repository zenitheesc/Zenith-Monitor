import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';

part 'data_state.dart';
part 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  late MissionVariablesList variablesList;
  final FirestoreServices fireServices = FirestoreServices();
  final UsbManager usbManager = UsbManager();

  DataBloc() : super(DataStateInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is SetVariablesListEvent) {
      variablesList = event.variablesList;
    } else if (event is FirestoreUploaderEvent) {
      fireServices.createAndUploadMission(event.variablesList);
    } else if (event is FirestoreDownloadEvent) {
    } else {
      print("Unknown event in Mission Bloc");
    }
  }
}

/// This pipeline is still incomplete. So far, its is only being used
/// to get the variable list from mission_creation widget. Delete these
/// comments if you are adding more content to this bloc.

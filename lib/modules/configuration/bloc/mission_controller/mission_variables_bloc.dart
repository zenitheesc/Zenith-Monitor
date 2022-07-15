import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/mission_variables_exceptions.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services_exceptions.dart';

part 'mission_variables_state.dart';
part 'mission_variables_event.dart';

/// This bloc has to do with the creation of current misson variables.
/// So, it deals with user interation in mission_creation.dart widget
/// and update the MissionVariableList object in mission pipeline.

class MissionVariablesBloc
    extends Bloc<MissionVariablesEvent, MissionVariablesState> {
  MissionVariablesList variablesList;
  DataBloc dataBloc;
  FirestoreServices firestoreServices = FirestoreServices();
  Map<String, bool> connections;
  final Connectivity _connectivity;

  MissionVariablesBloc(this.variablesList, this.dataBloc)
      : connections = <String, bool>{},
        _connectivity = Connectivity(),
        super(VariablesInitial()) {
    connections = {
      "Dispositivo usb": dataBloc.usbIsConnected,
      "Internet": false,
      //  "Modelo de pacote": (dataBloc.packageModel == null) ? false : true,
    };

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      connections["Internet"] =
          (result == ConnectivityResult.none) ? false : true;

      add(ConnectionChanged());
    });

    dataBloc.stream.listen((event) {
      if (event is UsbDisconnectedState) {
        connections["Dispositivo usb"] = false;
        add(ConnectionChanged());
      } else if (event is UsbConnectedState) {
        connections["Dispositivo usb"] = true;
        add(ConnectionChanged());
      }
    });
  }

  @override
  Stream<MissionVariablesState> mapEventToState(
      MissionVariablesEvent event) async* {
    if (event is AddStandardVariableEvent) {
      try {
        variablesList.addStandardVariable(
            event.variableName, event.variableType);
        yield VariablesChanged();
      } on VariableAlreadyExistsException {
        yield VariableInteractionError("Variável já existe");
      } on VariableTypeUnknownException {
        yield VariableInteractionError(
            "O tipo da variável é desconhecido, tente algo como string, int ou float");
      } on EmptyVariablesException {
        yield VariableInteractionError(
            "É necessário fornecer um nome e um tipo para a variável");
      }
    } else if (event is DeleteVariable) {
      variablesList.deleteVariable(event.variableIndex);
      yield VariablesChanged();
    } else if (event is StartMissionEvent) {
      if (event.missionName == "Nenhuma") {
        yield MissionNameError(
            "'Nenhuma' não pode ser utilizado como nome de missão.");
      } else if (event.missionName.isEmpty) {
        yield MissionNameError("É necessário fornecer um nome para a missão.");
      } else if (!event.ignoreLocationVar &&
          (!variablesList.contains("Latitude") ||
              !variablesList.contains("Longitude"))) {
        yield PackageWoLocationVar(missionName: event.missionName);
      } else {
        try {
          await firestoreServices.checkMissionName(event.missionName);
          dataBloc.add(MissionInfoSetup(
              missionName: event.missionName, packageModel: variablesList));
        } on EmptyMissionNameException {
          yield MissionNameError("É necessário fornecer um nome para a missão");
        } on MissionNameAlreadyExistException {
          yield MissionNameError(
              "Esse nome já foi utilizado em uma missão anterior");
        } catch (e) {
          print(e);
        }
      }
    } else if (event is ConnectionChanged) {
      yield NewConnectionsState(connections);
    } else {
      print("Unknown event in Variables Bloc");
    }
  }
}

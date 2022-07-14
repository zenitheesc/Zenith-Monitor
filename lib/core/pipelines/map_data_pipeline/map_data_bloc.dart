import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:zenith_monitor/utils/mixins/class_map_data.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';
import 'package:zenith_monitor/utils/helpers/routes_request.dart';

part 'map_data_state.dart';
part 'map_data_event.dart';

class MapDataBloc extends Bloc<MapDataEvent, MapDataState> {
  final LocationManager _selfLocationManager = LocationManager();
  UsbManager usbManager;
  FirestoreServices fireServices;
  late bool usbIsConnected;
  LocationData? trackerLocation;

  MapDataBloc({required this.usbManager, required this.fireServices})
      : super(MapDataStateInitial()) {
    usbIsConnected = false;

    _selfLocationManager.init();

    _selfLocationManager.locationStream().listen((event) {
      trackerLocation = event;
      //add(NewLocationData(locationData: event));
    });

    usbManager.attached().listen((event) {
      usbIsConnected = event;
    });

    usbManager.parsedData().listen((event) {
      add(NewPackage(newPackage: event));
    });

    fireServices.recive().listen((event) {
      if (!usbIsConnected) {
        add(NewPackage(newPackage: event));
      }
    });
  }

  @override
  Stream<MapDataState> mapEventToState(MapDataEvent event) async* {
    if (event is NewLocationData) {
      if (usbIsConnected) {
        //yield TrackerMoved();
      }
    } else if (event is NewPackage) {
      MissionVariable? latitude = event.newPackage.getVariable("Latitude");
      MissionVariable? longitude = event.newPackage.getVariable("Longitude");

      if (latitude == null || longitude == null) {
        yield PackageWoLocation();
      }
      LatLng probeLocation =
          LatLng(latitude!.getVariableValue(), longitude!.getVariableValue());

      if (!usbIsConnected) {
        yield NewProbeLocation(probeLocation: probeLocation);
      }

      MapData? mapData;
      if (trackerLocation != null &&
          trackerLocation!.latitude != null &&
          trackerLocation!.longitude != null) {
        mapData = await routesRequest(
            LatLng(trackerLocation!.latitude!, trackerLocation!.longitude!),
            probeLocation);
      }

      if (mapData != null) {
        yield NewMapData(mapData: mapData);
      } else {
        yield NewProbeLocation(probeLocation: probeLocation);
      }
    }
  }
}

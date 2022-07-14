import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:zenith_monitor/utils/mixins/class_map_data.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';
import 'package:zenith_monitor/utils/helpers/routes_request.dart';

part 'map_data_state.dart';
part 'map_data_event.dart';

class MapDataBloc extends Bloc<MapDataEvent, MapDataState> {
  final LocationManager _selfLocationManager = LocationManager();
  UsbManager usbManager;
  late bool usbIsConnected;
  LocationData? trackerLocation;

  MapDataBloc({required this.usbManager}) : super(MapDataStateInitial()) {
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
      MissionVariable? latitude = event.getVariable("Latitude");
      MissionVariable? longitude = event.getVariable("Longitude");
      if (latitude != null && longitude != null) {
        add(NewUsbCoordinate(latitude: latitude, longitude: longitude));
      }
    });
  }

  @override
  Stream<MapDataState> mapEventToState(MapDataEvent event) async* {
    if (event is NewLocationData) {
      if (usbIsConnected) {
        //yield TrackerMoved();
      }
    } else if (event is NewUsbCoordinate) {
      LatLng probeLocation = LatLng(event.latitude.getVariableValue(),
          event.longitude.getVariableValue());

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

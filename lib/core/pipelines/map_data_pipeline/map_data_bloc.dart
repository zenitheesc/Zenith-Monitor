import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';

part 'map_data_state.dart';
part 'map_data_event.dart';

class MapDataBloc extends Bloc<MapDataEvent, MapDataState> {
  final LocationManager _selfLocation = LocationManager();
  UsbManager usbManager;
  late bool usbIsConnected;

  MapDataBloc({required this.usbManager}) : super(MapDataStateInitial()) {
    usbIsConnected = false;

    _selfLocation.init();

    _selfLocation.locationStream().listen((event) {
      add(NewLocationData(locationData: event));
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
        yield TrackerMoved();
      }
    } else if (event is NewUsbCoordinate) {
      LatLng probeLocation = LatLng(event.latitude.getVariableValue(),
          event.longitude.getVariableValue());
      yield NewProbeLocation(probeLocation: probeLocation);
    }
  }
}

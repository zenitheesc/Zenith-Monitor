part of 'map_bloc.dart';

abstract class MapEvent {}

class NewPackageEvent extends MapEvent {
  MissionVariablesList newPackage;

  NewPackageEvent({required this.newPackage});
}

class UsbError extends MapEvent {}

class BuildNewPolyline extends MapEvent {
  MapData mapData;
  BuildNewPolyline({required this.mapData});
}

class BuildNewMarker extends MapEvent {
  LatLng probeLocation;
  BuildNewMarker({required this.probeLocation});
}

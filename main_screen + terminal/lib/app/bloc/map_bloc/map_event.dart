part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class MapStart extends MapEvent {}

class LocationChange extends MapEvent {
  final LatLng packet;
  LocationChange(this.packet);
}

class DataChange extends MapEvent {
  final TargetTrajectory packet;
  DataChange(this.packet);
}

class MapTypeChange extends MapEvent {
  final MapType mapType;
  MapTypeChange(this.mapType);
}

class MapTrafficChange extends MapEvent {
  final bool showTraffic;
  MapTrafficChange(this.showTraffic);
}

class MapError extends MapEvent {}

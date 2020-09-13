part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class LocationNewPacket extends LocationEvent {
  final LatLng packet;

  LocationNewPacket(this.packet);
}

class LocationError extends LocationEvent {}

class LocationStart extends LocationEvent {}

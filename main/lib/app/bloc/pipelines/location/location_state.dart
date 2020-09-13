part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationUpdated extends LocationState {
  final LatLng packet;

  LocationUpdated(this.packet);
}

class LocationLoading extends LocationState {}

class LocationFailed extends LocationState {}

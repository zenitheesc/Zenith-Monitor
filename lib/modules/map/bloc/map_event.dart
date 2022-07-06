part of 'map_bloc.dart';

abstract class MapEvent {}

class NewPackageEvent extends MapEvent {
  MissionVariablesList newPackage;

  NewPackageEvent({required this.newPackage});
}

class UsbError extends MapEvent {}

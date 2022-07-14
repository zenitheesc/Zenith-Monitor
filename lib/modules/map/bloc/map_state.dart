part of 'map_bloc.dart';

abstract class MapState {}

class MapInitialState extends MapState {}

class NewPackageState extends MapState {
  List newVariablesList;

  NewPackageState({required this.newVariablesList});
}

class MapError extends MapState {
  String errorMessage;
  MapError({required this.errorMessage});
}

class NewPolyline extends MapState {
  Map<PolylineId, Polyline> newPolyline;
  NewPolyline({required this.newPolyline});
}

class NewMarker extends MapState {
  Marker probeIcon;
  NewMarker({required this.probeIcon});
}

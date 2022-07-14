part of 'map_data_bloc.dart';

abstract class MapDataState {}

class MapDataStateInitial extends MapDataState {}

class TrackerMoved extends MapDataState {}

class NewProbeLocation extends MapDataState {
  LatLng probeLocation;
  NewProbeLocation({required this.probeLocation});
}

class NewMapData extends MapDataState {
  MapData mapData;
  NewMapData({required this.mapData});
}

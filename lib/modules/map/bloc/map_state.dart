part of 'map_bloc.dart';


abstract class MapState {}

class MapInitialState extends MapState {}

class LatLngState extends MapState {
  LatLng object;

  LatLngState({required this.object});
}

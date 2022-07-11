part of 'map_data_bloc.dart';

abstract class MapDataEvent {}

class NewLocationData extends MapDataEvent {
  LocationData locationData;
  NewLocationData({required this.locationData});
}

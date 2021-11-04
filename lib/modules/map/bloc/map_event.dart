part of 'map_bloc.dart';

abstract class MapEvent {}

class InfoMapEvent extends MapEvent {
  MissionVariablesList newPackage;

  InfoMapEvent({required this.object});
}

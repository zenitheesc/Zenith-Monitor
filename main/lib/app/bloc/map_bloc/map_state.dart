part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {
  final List<TargetTrajectory> target_trajectory = [];
  final LatLng user_position = LatLng(0, 0);
  final MapType mapType = MapType.normal;
  MapInitial();
}

class MapUpdated extends MapState {
  final List<TargetTrajectory> targetTrajectory;
  final LatLng userPosition;
  final MapType mapType;
  final bool showTraffic;
  MapUpdated(
      this.targetTrajectory, this.userPosition, this.mapType, this.showTraffic);
}

class MapFailed extends MapState {
  final String message;
  MapFailed(this.message);
}

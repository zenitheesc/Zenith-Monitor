part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {
  final List<TargetTrajectory> target_trajectory = [];
  final LatLng user_position = LatLng(0, 0);
  MapType mapType = MapType.normal;

  MapInitial();
}

class MapUpdated extends MapState {
  final List<TargetTrajectory> target_trajectory;
  final LatLng user_position;
  final MapType mapType;
  final bool showTraffic;
  MapUpdated(this.target_trajectory, this.user_position, this.mapType,
      this.showTraffic);
}

class MapFailed extends MapState {
  final String message;
  MapFailed(this.message);
}

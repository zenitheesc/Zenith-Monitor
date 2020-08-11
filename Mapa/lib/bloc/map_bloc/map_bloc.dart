import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firstattemptatmaps/bloc/data_bloc/data_bloc.dart';
import 'package:firstattemptatmaps/bloc/location_bloc/location_bloc.dart';
import 'package:firstattemptatmaps/models/target_trajectory.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  final DataBloc dataBloc;
  StreamSubscription _locationBlocSubscription;
  StreamSubscription _dataBlocSubscription;

  var _targetTrajectory = <TargetTrajectory>[];
  var _userPosition = LatLng(0, 0);
  var _mapType = MapType.normal;
  var _showTraffic = true;

  MapBloc(this.locationBloc, this.dataBloc) : super(MapInitial());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is MapStart) {
      dataBloc.add(DataStart());
      _dataBlocSubscription?.cancel();
      _dataBlocSubscription = dataBloc.listen((DataState state) {
        if (state is DataUpdated) {
          add(DataChange(state.packet));
        }
      });
      locationBloc.add(LocationStart());
      _locationBlocSubscription?.cancel();
      _locationBlocSubscription = locationBloc.listen((LocationState state) {
        if (state is LocationUpdated) {
          add(LocationChange(state.packet));
        }
      });
    } else if (event is DataChange) {
      _targetTrajectory.add(event.packet);
      yield MapUpdated(
          _targetTrajectory, _userPosition, _mapType, _showTraffic);
    } else if (event is LocationChange) {
      _userPosition = (event.packet);
      yield MapUpdated(
          _targetTrajectory, _userPosition, _mapType, _showTraffic);
    } else if (event is MapTypeChange) {
      _mapType = event.mapType;
      yield MapUpdated(
          _targetTrajectory, _userPosition, _mapType, _showTraffic);
    } else if (event is MapTrafficChange) {
      _showTraffic = event.showTraffic;
      yield MapUpdated(
          _targetTrajectory, _userPosition, _mapType, _showTraffic);
    } else if (event is MapError) {
      yield MapFailed("There was an error while loading the map");
    }
  }
}

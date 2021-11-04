import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bloc/bloc.dart';
part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitialState());

  LatLng latlng = LatLng(30, 20);
  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is LatLngEvent) {
      yield LatLngState(object: latlng);
    }
  }
}


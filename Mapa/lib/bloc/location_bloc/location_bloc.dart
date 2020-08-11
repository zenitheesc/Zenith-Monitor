import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firstattemptatmaps/components/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationManager location;
  StreamSubscription _src;
  StreamSubscription _stat;

  LocationBloc(this.location) : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    print(event);
    if (event is LocationStart) {
      yield LocationLoading();
      await location.init();
      _src?.cancel();
      _src = location.receive().listen((LatLng packet) {
        add(LocationNewPacket(packet));
      });
      _stat?.cancel();
      _stat = location.status().listen((event) {
        if (event < 0) {
          add(LocationError());
        }
      });
      yield LocationUpdated(LatLng(-22.01672, -47.89197));
    } else if (event is LocationNewPacket) {
      yield LocationUpdated(event.packet);
    } else if (event is LocationError) {
      yield LocationFailed();
      yield LocationUpdated(LatLng(-22.01672, -47.89197));
    }
  }

  @override
  void dispose() {
    _src?.cancel();
    _stat?.cancel();
  }
}

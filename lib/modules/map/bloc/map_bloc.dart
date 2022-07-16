import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/core/pipelines/map_data_pipeline/map_data_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_map_data.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:bloc/bloc.dart';
part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  DataBloc dataBloc;
  MapDataBloc mapDataBloc;

  MapBloc({required this.dataBloc, required this.mapDataBloc})
      : super(MapInitialState()) {
    mapDataBloc.stream.listen((event) {
      if (event is NewMapData) {
        add(BuildNewPolyline(mapData: event.mapData));
      } else if (event is NewProbeLocation) {
        add(BuildNewMarker(probeLocation: event.probeLocation));
      }
    });

    dataBloc.stream.listen((state) {
      if (state is NewPackageParsedData) {
        add(NewPackageEvent(newPackage: state.newPackage));
      } else if (state is UsbPackageNotDefined) {
        add(UsbError());
      }
    });
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is NewPackageEvent) {
      List variablesList = event.newPackage.getVariablesList();
      variablesList.removeAt(0);

      /// Removes the timestamp variable
      yield NewPackageState(newVariablesList: variablesList);
    } else if (event is UsbError) {
      yield MapError(
          errorMessage:
              "O dispositivo USB foi conectado, mas ainda não há modelo de pacote para o parser. Se novos pacotes chegarem, eles serão ignorados e perdidos. Para resolver isso, navegue até a página de configurações e escolha uma missão ou crie uma nova.");
    } else if (event is BuildNewPolyline) {
      Map<PolylineId, Polyline> newPolyline = _buildPolylinesMap(event.mapData);
      yield NewPolyline(newPolyline: newPolyline);
    } else if (event is BuildNewMarker) {
      Marker probeIcon = _setProbeLocation(event.probeLocation);
      yield NewMarker(probeIcon: probeIcon);
    }
  }

  Marker _setProbeLocation(LatLng location) {
    return Marker(
      markerId: const MarkerId('Probe'),
      position: location,
    );
  }

  Map<PolylineId, Polyline> _buildPolylinesMap(MapData mapData) {
    PolylineId routeId = const PolylineId("route_id");
    Polyline route = _buildPolyline(mapData.routePoints, Colors.red, routeId);

    List<LatLng> lineToProbe = [
      mapData.routePoints.last,
      mapData.probeLocation
    ];

    PolylineId polylineLId = const PolylineId('line_id');
    Polyline line = _buildPolyline(lineToProbe, Colors.yellow, polylineLId);

    Map<PolylineId, Polyline> polyinesMap = {};
    polyinesMap[routeId] = route;
    polyinesMap[polylineLId] = line;

    return polyinesMap;
  }

  Polyline _buildPolyline(List<LatLng> points, Color color, PolylineId id) {
    Polyline polylineRoute = Polyline(
      polylineId: id,
      consumeTapEvents: true,
      color: color,
      width: 5,
      points: points,
    );

    return polylineRoute;
  }
}

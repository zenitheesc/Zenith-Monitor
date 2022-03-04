import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:zenith_monitor/modules/map/bloc/map_bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/widgets/map/map_display/map_theme_button.dart';
import 'package:zenith_monitor/widgets/map/navigation_drawer/navigation_drawer.dart';

import 'map_display/info_listview.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => BuildMap();
}

class BuildMap extends State<MapSample> {
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();

  int _polylineIdCounter = 1;
  final Completer<GoogleMapController> _controller = Completer();
  // ignore: non_constant_identifier_names
  final Map<PolylineId, Polyline> _BuildMapolylines = {};
  MapType _maptype = MapType.normal;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-22.0123, -47.8908),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    MissionVariablesList t = MissionVariablesList();

    t.addStandardVariable('Latitude', 'String');
    t.addStandardVariable('Longitude', 'String');
    t.addStandardVariable('Altitude', 'String');
    t.addStandardVariable('Velocidade', 'String');
    t.addStandardVariable('name', 'String');

    t.addValueToVariable('Latitude', '30º');
    t.addValueToVariable('Longitude', '90º');
    t.addValueToVariable('Altitude', '5000m');
    t.addValueToVariable('Velocidade', '9m/s');
    t.addValueToVariable('name', '90');

    // t.removeMission(0);

    BlocProvider.of<MapBloc>(context).add(UserInfoEvent(newPackage: t));

    markers.addAll([
      const Marker(
          markerId: MarkerId('value'), position: LatLng(-22.0123, -47.8908)),
      const Marker(
          markerId: MarkerId('value2'),
          position: LatLng(-20.7333333, -48.5833333)),
    ]);

    return Scaffold(
      body: OrientationBuilder(
          builder: (context, orientation) => Align(
                alignment: Alignment.bottomCenter,
                child: Stack(children: <Widget>[
                  Column(children: [
                    Container(
                      width: screenSize(context, "width", 1),
                      height: screenSize(context, "height", 0.75),
                      child: GoogleMap(
                        mapType: _maptype,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) async {
                          _mapController = controller;
                          var style = await rootBundle
                              .loadString('assets/maps/aubergine.json');
                          _add();
                          _mapController.setMapStyle(style);
                          _controller.complete(controller);
                        },
                        markers: markers,
                        polylines: Set<Polyline>.of(_BuildMapolylines.values),
                      ),
                    ),
                    infoListView(context, orientation),
                  ]),
                  Positioned.fill(
                    left: getLeftPositionForOrientation(orientation),
                    bottom: getBottomPositionForOrientation(orientation),
                    child: mapThemeButton(context, orientation, this),
                  ),
                  Positioned.fill(
                      left: -1 * MediaQuery.of(context).size.width,
                      child: Center(
                        child: CustomPaint(
                            size: const Size(20, 50), painter: Draw()),
                      )),
                  Positioned.fill(
                      left: -0.975 * MediaQuery.of(context).size.width,
                      child: Center(
                          child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: IconButton(
                          color: Colors.white,
                          iconSize: MediaQuery.of(context).size.height * 0.02,
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ))),
                ]),
              )),
      drawer: navigationDrawerWidget(),
    );
  }

  double getLeftPositionForOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      return 0.92 * MediaQuery.of(context).size.width;
    }
    return -0.83 * MediaQuery.of(context).size.width;
  }

  double getBottomPositionForOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      return 0.45 * MediaQuery.of(context).size.height;
    }
    return -0.3 * MediaQuery.of(context).size.height;
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(const LatLng(-22.0123, -47.8908));
    points.add(const LatLng(-20.7333333, -48.5833333));
    return points;
  }

  void setMap() async {
    setState(() {
      if (_maptype == MapType.normal) {
        _maptype = MapType.satellite;
      } else {
        _maptype = MapType.normal;
      }
    });
  }

  Future<void> _add() async {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: _createPoints(),
    );

    setState(() {
      _BuildMapolylines[polylineId] = polyline;
    });
  }
}

double screenSize(BuildContext context, String type, double size) {
  if (type == "height") {
    return MediaQuery.of(context).size.height * size;
  } else {
    return MediaQuery.of(context).size.width * size;
  }
}

class Draw extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, 3.5 / 4 * size.height);
    path.lineTo(size.width, 0.5 / 4 * size.height);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

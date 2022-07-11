import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:zenith_monitor/widgets/map_info_listview.dart';
import 'package:zenith_monitor/widgets/map_theme_button.dart';
import 'package:zenith_monitor/widgets/map_navigation_drawer.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => BuildMap();
}

class BuildMap extends State<MapWidget> {
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();

  int _polylineIdCounter = 1;
  final Completer<GoogleMapController> _controller = Completer();
  final Map<PolylineId, Polyline> _buildMapolylines = {};
  MapType _maptype = MapType.normal;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-22.0123, -47.8908),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    markers.addAll([
      const Marker(
          markerId: MarkerId('value'), position: LatLng(-22.0123, -47.8908)),
      const Marker(
          markerId: MarkerId('value'), position: LatLng(-22.0135, -47.8908)),
      const Marker(
          markerId: MarkerId('value'), position: LatLng(-22.0135, -47.8928)),
      const Marker(
          markerId: MarkerId('value'), position: LatLng(-22.0139, -47.8930)),
      const Marker(
          markerId: MarkerId('value2'),
          position: LatLng(-20.7333333, -48.5833333)),
    ]);

    return Scaffold(
      body: OrientationBuilder(
          builder: (context, orientation) => Align(
                alignment: Alignment.bottomCenter,
                child: Stack(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
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
                      polylines: Set<Polyline>.of(_buildMapolylines.values),
                    ),
                  ),
                  InfoListView(
                    orientation: orientation,
                  ),
                  Positioned.fill(
                    left: getLeftPositionForOrientation(orientation),
                    bottom: getBottomPositionForOrientation(orientation),
                    child: MapThemeButton(buildMap: this),
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
      drawer: NavigationDrawerWidget(),
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
    points.add(const LatLng(-22.0134, -47.8908));
    points.add(const LatLng(-22.0134, -47.8912));
    points.add(const LatLng(-22.0139, -47.8915));
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
      _buildMapolylines[polylineId] = polyline;
    });
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

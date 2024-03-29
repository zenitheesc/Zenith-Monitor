import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/modules/map/bloc/map_bloc.dart';
import 'package:zenith_monitor/widgets/map_info_listview.dart';
import 'package:zenith_monitor/widgets/map_theme_button.dart';
import 'package:zenith_monitor/widgets/map_navigation_drawer.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => BuildMap();
}

class BuildMap extends State<MapWidget> {
  Marker? probeLocation;
  MapBloc? mapBloc;

  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> _polylinesMap = {};
  MapType _maptype = MapType.normal;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-22.0123, -47.8908),
    zoom: 14.4746,
  );

  @override
  void dispose() {
    super.dispose();

    //Close the Stream Sink when the widget is disposed
    mapBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.stream.listen(((state) {
      if (state is NewPolyline) {
        setState(() {
          _polylinesMap = state.newPolyline;
        });
      } else if (state is NewMarker) {
        setState(() {
          probeLocation = state.probeIcon;
        });
      }
    }));

    return Scaffold(
      body: OrientationBuilder(
          builder: (context, orientation) => Align(
                alignment: Alignment.bottomCenter,
                child: Stack(children: <Widget>[
                  GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    mapType: _maptype,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) async {
                      _mapController = controller;
                      var style = await rootBundle
                          .loadString('assets/maps/aubergine.json');
                      _mapController.setMapStyle(style);
                      _controller.complete(controller);
                    },
                    markers: {
                      if (probeLocation != null) probeLocation!,
                    },
                    polylines: Set<Polyline>.of(_polylinesMap.values),
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

  void setMap() async {
    setState(() {
      if (_maptype == MapType.normal) {
        _maptype = MapType.satellite;
      } else {
        _maptype = MapType.normal;
      }
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

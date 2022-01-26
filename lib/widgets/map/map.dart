import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/map/bloc/map_bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/widgets/map/navigation_drawer.dart';
import 'package:zenith_monitor/widgets/map/map_cards.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => Mapp();
}

class Mapp extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  final Map<PolylineId, Polyline> _mapPolylines = {};

  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  MapType _maptype = MapType.normal;
  int _polylineIdCounter = 1;

  void _setMap() async {
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
      _mapPolylines[polylineId] = polyline;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-20.554331116, -48.567331064),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    markers.addAll([
      const Marker(
          markerId: MarkerId('value'),
          position: LatLng(-20.554331116, -48.567331064)),
      const Marker(
          markerId: MarkerId('value2'),
          position: LatLng(-20.7333333, -48.5833333)),
    ]);

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

    return Scaffold(
      body: Builder(
          builder: (context) => Align(
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
                        polylines: Set<Polyline>.of(_mapPolylines.values),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: screenSize(context, "height", 0.25),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: BlocBuilder<MapBloc, MapState>(
                                builder: (context, state) {
                              if (state is UserInfoState) {
                                List scrollList =
                                    state.newPackage.getVariablesList();

                                return ListView.separated(
                                    itemCount: scrollList.length % 2 == 0
                                        ? scrollList.length ~/ 2
                                        : scrollList.length ~/ 2 + 1,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Divider(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (2 * index + 1 < scrollList.length) {
                                        return informations(
                                            context,
                                            scrollList[index * 2]
                                                .getVariableName()
                                                .toString(),
                                            scrollList[index * 2 + 1]
                                                .getVariableName()
                                                .toString(),
                                            scrollList[index * 2]
                                                .getVariableValue()
                                                .toString(),
                                            scrollList[index * 2 + 1]
                                                .getVariableValue()
                                                .toString());
                                      } else {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.23,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.23),
                                          child: informationsContainer(
                                              context,
                                              scrollList[index * 2]
                                                  .getVariableName()
                                                  .toString(),
                                              scrollList[index * 2]
                                                  .getVariableName()
                                                  .toString()),
                                        );
                                      }
                                    });
                              }
                              return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const []);
                            }))
                      ],
                    ),
                  ]),
                  Positioned.fill(
                    left: -MediaQuery.of(context).size.width +
                        1.8 / 10 * MediaQuery.of(context).size.width,
                    bottom: -MediaQuery.of(context).size.height * 0.33,
                    child: Center(
                      child: Container(
                          height: screenSize(context, "height", 0.08),
                          child: SizedBox.fromSize(
                            size: Size(
                                screenSize(context, "height", 0.068),
                                screenSize(context, "height",
                                    0.068)), // button width and height
                            child: ClipPath(
                              child: Material(
                                color: eerieBlack, // button color
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0.8),
                                  // splash color
                                  onTap: () {
                                    _setMap();
                                  },
                                  // button pressed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Text(
                                        "Tema",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: white,
                                        ),
                                      ), // icon
                                      Icon(
                                        Icons.palette,
                                        color: white,
                                      ), // text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                  Positioned.fill(
                      left: -MediaQuery.of(context).size.width +
                          0.5 / 10 * MediaQuery.of(context).size.width,
                      child: Center(
                        child: CustomPaint(
                            size: const Size(20, 50), painter: Draw()),
                      )),
                  Positioned.fill(
                      left: -MediaQuery.of(context).size.width +
                          0.75 / 10 * MediaQuery.of(context).size.width,
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

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(const LatLng(-20.554331116, -48.567331064));
    points.add(const LatLng(-20.7333333, -48.5833333));
    return points;
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

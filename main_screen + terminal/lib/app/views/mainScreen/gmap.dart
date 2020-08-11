import 'dart:async';

import 'package:zenith_monitor/app/bloc/map_bloc/map_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/models/target_trajectory.dart';

class GMapsConsumer extends StatefulWidget {
  GMapsConsumer({Key key}) : super(key: key);

  @override
  _GMapsConsumerState createState() => _GMapsConsumerState();
}

class _GMapsConsumerState extends State<GMapsConsumer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MapBloc>(context).add(MapStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is MapFailed) {
          return Center(child: Text(state.message));
        } else if (state is MapUpdated) {
          return GMapsView(
            target_points: state.targetTrajectory,
            user_position: state.userPosition,
            mapType: state.mapType,
            showTraffic: state.showTraffic,
          );
        } else if (state is MapInitial) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("you shouldn't be seeing this"));
        }
      },
    );
  }
}

class GMapsView extends StatefulWidget {
  final List<TargetTrajectory> target_points;
  final LatLng user_position;
  final MapType mapType;
  final bool showTraffic;
  GMapsView(
      {Key key,
      this.target_points,
      this.user_position,
      this.mapType,
      this.showTraffic})
      : super(key: key);

  @override
  _GMapsViewState createState() => _GMapsViewState();
}

class _GMapsViewState extends State<GMapsView> {
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-22.016720, -47.891972), // SC
    zoom: 7.0,
  );

  Set<Marker> markers = {};
  Set<Polyline> lines = {};

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    for (TargetTrajectory position in widget.target_points) {
      markers.add(_makeMarker(position));
      lines.add(_makeDevicePath(position));

      // List<LatLng> loc_to_device = [
      //   widget.user_position,
      //   widget.target_points.last.position
      // ];
      // var ltd = Polyline(
      //   polylineId: PolylineId("loc_to_device"),
      //   consumeTapEvents: false,
      //   color: Colors.blue,
      //   width: 5,
      //   points: loc_to_device.map((e) => e).toList(),
      //   zIndex: 0,
      // );
      // lines.add(ltd);
    }

    return Container(
      child: GoogleMap(
        mapType: widget.mapType,
        trafficEnabled: widget.showTraffic,
        myLocationButtonEnabled: true,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        mapToolbarEnabled: true,
        liteModeEnabled: false, // lite mode is a static image
        polylines: lines,
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }

  Marker _makeMarker(TargetTrajectory position) {
    return Marker(
        position: position.position,
        zIndex: position.altitude,
        alpha: 0.75,
        infoWindow: InfoWindow(
            title: "Alt: ${position.altitude.toStringAsFixed(4)}",
            snippet:
                "(${position.position.latitude.toStringAsFixed(4)},${position.position.latitude.toStringAsFixed(4)})"),
        markerId: MarkerId((position.position.longitude +
                position.position.latitude)
            .toString()) // this is problematic;.toStringAsFixed(4) solution use received index
        );
  }

  Polyline _makeDevicePath(TargetTrajectory position) {
    return Polyline(
        polylineId: PolylineId("device_path"),
        consumeTapEvents: false,
        color: Colors.pink,
        width: 2,
        points: widget.target_points.map((e) => e.position).toList(),
        zIndex: 1);
  }
}

import 'dart:async';

import 'package:firstattemptatmaps/bloc/data_bloc/data_bloc.dart';
import 'package:firstattemptatmaps/bloc/location_bloc/location_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firstattemptatmaps/models/map_event.dart';
import 'package:location/location.dart';

class GMapsConsumer extends StatefulWidget {
  GMapsConsumer({Key key}) : super(key: key);

  @override
  _GMapsConsumerState createState() => _GMapsConsumerState();
}

class _GMapsConsumerState extends State<GMapsConsumer> {
  List<TargetTrajectory> points = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<LocationBloc>(context).add(LocationStart());
    BlocProvider.of<DataBloc>(context).add(DataStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, DataState data_state) {
        if (data_state is DataInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (data_state is DataUpdated) {
          points.add(data_state.packet);
          return Container(
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, LocationState state) {
                print(state);
                if (state is LocationInitial) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is LocationLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is LocationUpdated) {
                  print('new data');
                  print(state.packet);
                  return Center(
                      child: GMapsView(
                    target_points: points,
                    user_position: state.packet,
                  ));
                }
                if (state is LocationFailed) {
                  print('location failed');
                  return Center(child: Text("nothing"));
                }
                return Center(child: Text("This is an Error"));
              },
            ),
          );
        }
        return Center(
          child: Text("This is an Error"),
        );
      },
    );
  }
}

class GMapsView extends StatefulWidget {
  final List<TargetTrajectory> target_points;
  final LatLng user_position;
  GMapsView({Key key, this.target_points, this.user_position})
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

  _GMapsViewState() {}

  @override
  void didChangeDependencies() {
    print('update  dep');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    for (var position in widget.target_points) {
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
        mapType: MapType.normal,
        trafficEnabled: true,
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

  Polyline _makeDevicePath(position) {
    return Polyline(
        polylineId: PolylineId("device_path"),
        consumeTapEvents: false,
        color: Colors.pink,
        width: 2,
        points: widget.target_points.map((e) => e.position).toList(),
        zIndex: 1);
  }
}

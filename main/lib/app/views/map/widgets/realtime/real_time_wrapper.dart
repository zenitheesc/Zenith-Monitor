import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/bloc/pipelines/data/data_bloc.dart';
import 'package:zenith_monitor/app/views/map/widgets/datatypes.dart';
import 'package:zenith_monitor/app/views/map/widgets/realtime/scrollable_draggable_sheet.dart';
import 'package:zenith_monitor/app/views/map/widgets/speedometer_icons.dart';

class RealTimeSheet extends StatefulWidget {
  RealTimeSheet({Key key}) : super(key: key);

  @override
  _RealTimeSheetState createState() => _RealTimeSheetState();
}

class _RealTimeSheetState extends State<RealTimeSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        DataType altitude = DataType(
          name: "Altitude",
          numericData: "--",
          unit: "KM",
          previousData: null,
          icon: Icons.terrain,
        );

        DataType velocidade = DataType(
          name: "Velocidade",
          numericData: "--",
          unit: "KM/H",
          previousData: null,
          icon: Speedometer.speedometer,
        );

        DataType latitude = DataType(
          name: "Latitude",
          numericData: "--",
          unit: "o",
          previousData: null,
          icon: Icons.gps_fixed,
        );

        DataType longitude = DataType(
          name: "Longitude",
          numericData: "--",
          unit: "o",
          previousData: null,
          icon: Icons.gps_fixed,
        );
        if (state is DataUpdated) {
          altitude.numericData = state.packet.altitude.toStringAsFixed(2);
          velocidade.numericData = state.packet.speed.toStringAsFixed(2);
          latitude.numericData =
              state.packet.position.latitude.toStringAsFixed(4);
          longitude.numericData =
              state.packet.position.longitude.toStringAsFixed(4);

          // return DraggableSheet(
          //   topLeft: altitude,
          //   topRight: velocidade,
          //   bottomLeft: latitude,
          //   bottomRight: longitude,
          // );
        }
        return DraggableSheet(
          topLeft: altitude,
          topRight: velocidade,
          bottomLeft: latitude,
          bottomRight: longitude,
        );
      },
    );
  }
}

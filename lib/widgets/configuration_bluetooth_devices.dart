import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';

class BluetoothDevicesList extends StatelessWidget {
  const BluetoothDevicesList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
              onPressed: () => BlocProvider.of<MissionVariablesBloc>(context)
                  .add(SearchBluetoothDevices()),
              child: const Text(
                "Procura",
                style: TextStyle(color: white),
              )),
        ),
        BlocBuilder<MissionVariablesBloc, MissionVariablesState>(
          buildWhen: (previus, current) => current is NewBluetoothDevices,
          builder: (context, state) {
            if (state is NewBluetoothDevices) {
              print(state.bluetoothDevices.toString());
              for (BluetoothDevice device in state.bluetoothDevices) {
                print(device.name! +
                    " " +
                    device.isBonded.toString() +
                    " " +
                    device.bondState.stringValue);
              }
            }
            return Container(color: mantisGreen);
          },
        )
      ],
    );
  }
}

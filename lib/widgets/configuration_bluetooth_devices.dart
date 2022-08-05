import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';
import 'package:zenith_monitor/widgets/configuration_table.dart';

class BluetoothDevicesList extends StatelessWidget {
  const BluetoothDevicesList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: BlocBuilder<MissionVariablesBloc, MissionVariablesState>(
              buildWhen: (previous, current) =>
                  (current is BluetoothDiscoveryFinished) ||
                  (current is DiscoveringBluetoothDevices),
              builder: (context, state) {
                if (state is DiscoveringBluetoothDevices) {
                  return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: white,
                        strokeWidth: 3,
                      ));
                }
                return SizedBox(
                  height: 40,
                  child: TextButton(
                    onPressed: () =>
                        BlocProvider.of<MissionVariablesBloc>(context)
                            .add(SearchBluetoothDevices()),
                    child: const Text(
                      "Procura",
                      style: TextStyle(color: white),
                    ),
                  ),
                );
              },
            ),
          ),
          const ConfigurationTable(
              updateByState: NewBluetoothDevices,
              titleLeft: "Despsitivo",
              titleRight: "Estado",
              eventBygesture: ConnectToDevice),
        ],
      ),
    );
  }
}

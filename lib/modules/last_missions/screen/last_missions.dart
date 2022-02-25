import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/services/location/location.dart';

import '../bloc/last_missions_bloc.dart';

class LastMissions extends StatelessWidget {
  LastMissions({Key? key}) : super(key: key);

  final LocationManager data = LocationManager();
  @override
  Widget build(BuildContext context) {
    data.init();
    return const MaterialApp(
      home: LastMissionsBloc(),
    );
  }
}

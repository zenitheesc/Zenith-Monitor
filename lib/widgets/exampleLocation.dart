import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:zenith_monitor/utils/services/location.dart';

class ExampleLocation extends StatelessWidget {
  ExampleLocation({Key? key}) : super(key: key);

  final LocationManager data = LocationManager();

  @override
  Widget build(BuildContext context) {
    data.init();
    return Material();
  }
}

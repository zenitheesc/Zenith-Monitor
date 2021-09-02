import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:zenith_monitor/utils/services/location.dart';

class ExampleLocation extends StatelessWidget {
  ExampleLocation({Key? key}) : super(key: key);

  final LocationManager a = LocationManager();

  @override
  Widget build(BuildContext context) {
    a.init();
    print(a.status().listen((event) {
    }));
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: [
          MyAppBar(),
          LocationManager().build(context),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  // Fields in a Widget subclass are always marked "final".

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.black),
      // Row is a horizontal, linear layout.
    );
  }
}

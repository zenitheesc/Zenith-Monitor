import 'package:flutter/material.dart';
import 'package:zenith_monitor/modules/bluetooth/bluetooth_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bluetooth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothScreen(),  // Defina a tela inicial como BluetoothScreen
    );
  }
}
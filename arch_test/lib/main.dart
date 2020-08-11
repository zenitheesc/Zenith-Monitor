import 'package:arch_test/app/blocs/bluetooth/bluetooth.dart';
import 'package:arch_test/app/blocs/status_bloc/status_bloc.dart';
import 'package:arch_test/app/blocs/data_bloc/data_bloc.dart';
import 'package:arch_test/app/blocs/logger/logger.dart';
import 'package:arch_test/app/blocs/usb/usb.dart';
import 'package:arch_test/app/views/LoginPage.dart';
import 'package:arch_test/app/views/MapPage.dart';
import 'package:arch_test/app/views/TerminalPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/map': (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      DataBloc(Bluetooth(), UsbSerial(), Logger()),
                ),
                BlocProvider(
                  create: (context) => StatusBloc(
                      context.bloc<DataBloc>().bluetooth,
                      context.bloc<DataBloc>().usb,
                      context.bloc<DataBloc>().logger),
                ),
              ],
              child: MapPage(),
            ),
        '/terminal': (context) => TerminalPage(),
      },
      initialRoute: '/',
    );
  }
}

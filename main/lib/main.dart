import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenith_monitor/app/bloc/pipelines/data/data_bloc.dart';
import 'package:zenith_monitor/app/bloc/pipelines/location/location_bloc.dart';
import 'package:zenith_monitor/app/bloc/pipelines/logger/logger_bloc.dart';
import 'package:zenith_monitor/app/bloc/pipelines/status/status_bloc.dart';

import 'package:zenith_monitor/app/services/data/firebase_downloader.dart';
import 'package:zenith_monitor/app/services/uploader/firebase_uploader.dart';
import 'package:zenith_monitor/app/services/mock/local_database.dart';
import 'package:zenith_monitor/app/services/usb/usb.dart';
import 'package:zenith_monitor/app/services/location/location.dart';

import 'package:zenith_monitor/app/bloc/controllers/map/map_bloc.dart';
import 'package:zenith_monitor/app/bloc/controllers/terminal/terminal_bloc.dart';

import 'app/views/map/map_view.dart';
import 'app/views/terminal/terminal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Application());
}

// just in case
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataBloc(
            FirebaseReceiver(),
            UsbManager(),
          ),
        ),
        BlocProvider(
          create: (context) => LocationBloc(LocationManager()),
        ),
        BlocProvider(
          create: (context) => MapBloc(
            BlocProvider.of<LocationBloc>(context),
            BlocProvider.of<DataBloc>(context),
          ),
        ),
        BlocProvider(
          create: (context) => LoggerBloc(
            BlocProvider.of<DataBloc>(context),
            FirebaseUploader(),
            LocalDatabase(),
            BlocProvider.of<DataBloc>(context).usbManager,
          ),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => StatusBloc(
            BlocProvider.of<DataBloc>(context).dataReceiver,
            BlocProvider.of<LoggerBloc>(context).dataUploader,
            BlocProvider.of<DataBloc>(context).usbManager,
          ),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => TerminalBloc(
            BlocProvider.of<DataBloc>(context),
            BlocProvider.of<StatusBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        showPerformanceOverlay: false, // shows fps
        debugShowCheckedModeBanner: false,
        title: 'Main Screen',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        initialRoute: '/map',
        routes: {
          // '/login': (context) => LoginPage(),
          '/map': (context) => MainScreen(),
          '/terminal': (context) => TerminalView2(),
        },
      ),
    );
  }
}

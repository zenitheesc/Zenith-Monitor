import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/bloc/data_bloc/data_bloc.dart';
import 'package:zenith_monitor/app/bloc/location_bloc/location_bloc.dart';
import 'package:zenith_monitor/app/bloc/logger_bloc/logger_bloc.dart';
import 'package:zenith_monitor/app/bloc/map_bloc/map_bloc.dart';
import 'package:zenith_monitor/app/bloc/terminal_bloc/terminal_bloc.dart';
import 'package:zenith_monitor/app/components/data.dart';
import 'package:zenith_monitor/app/components/location.dart';
import 'package:zenith_monitor/app/models/target_trajectory.dart';

import 'app/bloc/status_bloc/status_bloc.dart';
import 'app/views/loginPage/fakeLoginPage.dart';
import 'app/views/mainScreen/widgets/mainScreenWidget.dart';
import 'app/views/terminal/terminal.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  // Not a real part of the project ----------------------------------------------
  // Stream<String> fakeDataSend =
  //     Stream<String>.periodic(Duration(seconds: 1), (int count) {
  //   return ('$count, ${count * 5}, ${count * 1.7 + 10}, ${count * 41.5 - 2}, ${count * 11}, ${count + 255}, 5');
  // }).take(100);
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataBloc(DataManager()),
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
            DataUploader(),
            LocalDatabase(),
          ),
        ),
        BlocProvider(
          create: (context) => StatusBloc(
            DataReceiver(),
            DataUploaderWithStaus(),
            UsbManager(),
          ),
        ),
        BlocProvider(
          create: (context) => TerminalBloc(
            BlocProvider.of<DataBloc>(context),
            BlocProvider.of<StatusBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        title: 'Main Screen',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        initialRoute: '/map',
        routes: {
          '/login': (context) => LoginPage(),
          '/map': (context) => MainScreen(),
          '/terminal': (context) => TerminalView2(),
        },
      ),
    );
  }
}

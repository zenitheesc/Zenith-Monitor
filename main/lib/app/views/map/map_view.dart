import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/bloc/pipelines/logger/logger_bloc.dart';
import 'package:zenith_monitor/app/bloc/pipelines/status/status_bloc.dart';
import 'package:zenith_monitor/app/bloc/controllers/terminal/terminal_bloc.dart';
import 'package:zenith_monitor/app/views/map/widgets/gmap/gmap.dart';
import 'package:zenith_monitor/app/views/map/widgets/realtime/real_time_wrapper.dart';

import './widgets/gmap/line_of_buttons.dart';
// import './widgets/realtime/scrollable_draggable_sheet.dart';
import './widgets/sidebar.dart';
import 'package:zenith_monitor/app/views/map/widgets/datatypes.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<LoggerBloc>(context).add(LoggerStart());
    BlocProvider.of<StatusBloc>(context).add(StatusStart());
    BlocProvider.of<TerminalBloc>(context).add(TerminalStart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GMapsConsumer(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: LineOfButtons(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RealTimeSheet(),
            ),
          ],
        ),
      ),
      drawer: SideBar(user),
      // drawerEnableOpenDragGesture: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/bloc/status_bloc/status_bloc.dart';
import 'package:zenith_monitor/app/bloc/terminal_bloc/terminal_bloc.dart';
import 'package:zenith_monitor/app/views/mainScreen/gmap.dart';

import 'line_of_buttons.dart';
import 'scrollable_draggable_sheet.dart';
import 'sidebar.dart';
import '../datatypes.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
              child: LineOfButtons(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DraggableSheet(),
            ),
          ],
        ),
      ),
      drawer: SideBar(user),
      // drawerEnableOpenDragGesture: true,
    );
  }
}

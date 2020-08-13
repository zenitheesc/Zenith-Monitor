import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/bloc/logger_bloc/logger_bloc.dart';
import 'package:zenith_monitor/app/bloc/status_bloc/status_bloc.dart';
import 'package:zenith_monitor/app/bloc/terminal_bloc/terminal_bloc.dart';
import 'package:zenith_monitor/app/views/mainScreen/gmap.dart';

import './lineOfButtons.dart';
import './scrollableDraggableSheet.dart';
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
      body: Stack(
        children: <Widget>[
          GMapsConsumer(),
          Align(
            alignment: Alignment(-0.9, -0.9),
            child: LineOfButtons(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableSheet(),
          ),
        ],
      ),
      drawer: SideBar(user),
      // drawerEnableOpenDragGesture: true,
    );
  }
}

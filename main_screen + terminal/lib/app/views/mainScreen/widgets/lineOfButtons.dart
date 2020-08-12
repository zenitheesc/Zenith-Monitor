import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/bloc/data_bloc/data_bloc.dart';
import 'package:zenith_monitor/app/bloc/logger_bloc/logger_bloc.dart';
import 'package:zenith_monitor/app/bloc/map_bloc/map_bloc.dart';

class LineOfButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 5,
            left: 5,
            right: 5,
          ),
          child: Builder(
            builder: (context) => FloatingActionButton(
              heroTag: "openDrawerBtn",
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(Icons.list),
              foregroundColor: Colors.black54,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            heroTag: "goHomeBtn",
            onPressed: () {
              BlocProvider.of<DataBloc>(context).add(UsbStart());
              BlocProvider.of<LoggerBloc>(context).add(LoggerStart());
            }, //widget.__mapKey.currentState.goHome,
            child: Icon(Icons.usb),
            foregroundColor: Colors.black54,
            backgroundColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            heroTag: "setBearingViewBtn",
            onPressed: () => BlocProvider.of<MapBloc>(context).add(
                MapTrafficChange(
                    true)), // widget.__mapKey.currentState.setBearingView,
            child: Icon(Icons.traffic),
            foregroundColor: Colors.black54,
            backgroundColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MapTypeFab(),
        )
      ],
    );
  }
}

class MapTypeFab extends StatefulWidget {
  MapTypeFab();

  @override
  _MapTypeFabState createState() => _MapTypeFabState();
}

class _MapTypeFabState extends State<MapTypeFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _iconColor;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  final double _mapButtonsHeight = 45.0;
  final List<String> mapType = [
    " Default Map ",
    "Satellite Map",
    "  Hybrid Map ",
    " Terrain Map "
  ];

  final List<MapType> mapTypeList = [
    MapType.normal,
    MapType.satellite,
    MapType.hybrid,
    MapType.terrain,
  ];

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _iconColor = ColorTween(
      begin: Colors.black54,
      end: Colors.white,
    ).animate(_animateIcon);
    _buttonColor = ColorTween(
      begin: Colors.white,
      end: Colors.black54,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _mapButtonsHeight,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: Curves.easeOut,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget main_button() {
    return Container(
      child: FloatingActionButton(
        heroTag: "mapTypeBtn",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'main_button',
        child: AnimatedIcon(
          icon: AnimatedIcons.view_list,
          color: _iconColor.value,
          progress: _animateIcon,
        ),
      ),
    );
  }

  List<Widget> map_type_buttons() {
    List<Widget> mapTypeButtons = [];

    for (var i = 0; i < 4; i++) {
      mapTypeButtons.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, _translateButton.value * (i + 1), 0.0),
          child: Visibility(
            visible: isOpened,
            child: RaisedButton(
              onPressed: () {
                // widget.mapStreamController.add(mapTypeList[i]);
                BlocProvider.of<MapBloc>(context)
                    .add(MapTypeChange(mapTypeList[i]));
                animate();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Text(
                mapType[i],
                style: TextStyle(
                  color: Colors.black54,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return mapTypeButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        main_button(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: map_type_buttons(),
        ),
      ],
    );
  }
}

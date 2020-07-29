import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../map.dart';

class LineOfButtons extends StatefulWidget {
  GlobalKey<MapSampleState> __mapKey;
  StreamController<MapType> mapStreamController = StreamController<MapType>();

  LineOfButtons(this.__mapKey, this.mapStreamController);

  @override
  _LineOfButtonsState createState() => _LineOfButtonsState();
}

class _LineOfButtonsState extends State<LineOfButtons> {
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
            onPressed: widget.__mapKey.currentState.goHome,
            child: Icon(Icons.home),
            foregroundColor: Colors.black54,
            backgroundColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            heroTag: "setBearingViewBtn",
            onPressed: widget.__mapKey.currentState.setBearingView,
            child: Icon(Icons.near_me),
            foregroundColor: Colors.black54,
            backgroundColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MapTypeFab(widget.mapStreamController),
        )
      ],
    );
  }
}

class MapTypeFab extends StatefulWidget {
  StreamController<MapType> mapStreamController = StreamController<MapType>();
  MapTypeFab(this.mapStreamController);

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
  double _mapButtonsHeight = 45.0;

  List<String> mapType = [
    " Default Map ",
    "Satellite Map",
    "  Hybrid Map ",
    " Terrain Map "
  ];

  List<MapType> mapTypeList = [
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
                widget.mapStreamController.add(mapTypeList[i]);
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

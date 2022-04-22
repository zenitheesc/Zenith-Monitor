import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/map.dart';

class MapThemeButton extends StatelessWidget {
  final BuildMap buildMap;
  const MapThemeButton({required this.buildMap});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: eerieBlack,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Tema",
                style: TextStyle(
                  fontSize: 12,
                  color: white,
                ),
              )),
          IconButton(
            onPressed: () => buildMap.setMap(),
            icon: const Icon(
              Icons.palette,
              size: 25,
              color: white,
            ),
          )
        ],
      ),
    ));
  }
}

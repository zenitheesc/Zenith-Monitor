import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class TitleSection extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  Orientation deviceOrientation;

  TitleSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.8 * screenWidth,
        padding: EdgeInsets.only(top: 0.10 * screenHeight),
        child: Text('Esqueci minha \nsenha',
            style: TextStyle(
                color: white,
                fontFamily: 'DMSans',
                fontSize: _fontSize(),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start));
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.05 * screenHeight
        : 0.03 * screenWidth;
  }
}

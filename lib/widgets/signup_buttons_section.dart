import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/elevated_button_container.dart';

class ButtonsSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;
  final VoidCallback? funcConfirm;

  const ButtonsSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation,
      required this.funcConfirm});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButtonContainer(
        labelText: 'Voltar',
        textStyle: TextStyle(
            color: white, fontSize: _fontSize(), fontFamily: 'DMSans'),
        width: 0.39 * screenWidth,
        height: 0.05 * screenHeight,
        margin: _margin(),
        borderRadius: 0.03 * screenHeight,
        buttonColor: lightCoral,
        buttonFunction: () => Navigator.pop(context),
      ),
      ElevatedButtonContainer(
        labelText: 'Submeter',
        textStyle: TextStyle(
            color: white, fontSize: _fontSize(), fontFamily: 'DMSans'),
        width: 0.39 * screenWidth,
        height: 0.05 * screenHeight,
        margin: _margin(),
        borderRadius: 0.03 * screenHeight,
        buttonColor: mantisGreen,
        buttonFunction: funcConfirm,
      )
    ]);
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.025 * screenHeight
        : 0.0195 * screenWidth;
  }

  EdgeInsets _margin() {
    return EdgeInsets.only(
        left: 0.01 * screenWidth,
        top: 0.16 * screenHeight,
        right: 0.01 * screenWidth);
  }
}

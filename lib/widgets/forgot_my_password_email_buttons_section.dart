import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/elevated_button_container.dart';
import 'package:zenith_monitor/widgets/text_field_container.dart';

class EmailButtonsSection extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  Orientation deviceOrientation;

  EmailButtonsSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextFieldContainer(
          labelText: 'Email cadastrado',
          fontSize: _fontSize(),
          width: 0.80 * screenWidth,
          height: 0.09 * screenHeight,
          margin: EdgeInsets.only(bottom: 0.03 * screenHeight)),
      ElevatedButtonContainer(
          labelText: 'Submeter',
          textStyle: TextStyle(
              color: Colors.black, fontSize: _fontSize(), fontFamily: 'DMSans'),
          width: 0.62 * screenWidth,
          height: 0.07 * screenHeight,
          margin: EdgeInsets.only(
              top: 0.03 * screenHeight, bottom: 0.02 * screenHeight),
          borderRadius: 0.016 * screenHeight,
          buttonColor: white),
      ElevatedButtonContainer(
          labelText: 'Voltar',
          textStyle: TextStyle(
              color: white, fontSize: _fontSize(), fontFamily: 'DMSans'),
          width: 0.62 * screenWidth,
          height: 0.06 * screenHeight,
          margin: EdgeInsets.only(top: 0.02 * screenHeight),
          borderRadius: 0.03 * screenHeight,
          buttonColor: lightCoral)
    ]);
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.030 * screenHeight
        : 0.025 * screenWidth;
  }
}

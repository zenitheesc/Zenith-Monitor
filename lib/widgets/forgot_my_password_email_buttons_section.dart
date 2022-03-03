import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/elevated_button_container.dart';
import 'package:zenith_monitor/widgets/text_field_container.dart';

class EmailButtonsSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;
  final TextEditingController emailController;

  const EmailButtonsSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation,
      required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextFieldContainer(
          controller: emailController,
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
        buttonColor: white,
        buttonFunction: () => Navigator.pop(context),
      ),
      ElevatedButtonContainer(
        labelText: 'Voltar',
        textStyle: TextStyle(
            color: white, fontSize: _fontSize(), fontFamily: 'DMSans'),
        width: 0.62 * screenWidth,
        height: 0.06 * screenHeight,
        margin: EdgeInsets.only(top: 0.02 * screenHeight),
        borderRadius: 0.03 * screenHeight,
        buttonColor: lightCoral,
        buttonFunction: () => Navigator.pop(context),
      )
    ]);
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.030 * screenHeight
        : 0.025 * screenWidth;
  }
}

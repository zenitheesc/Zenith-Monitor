import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/elevated_button_container.dart';
import 'package:zenith_monitor/widgets/text_field_container.dart';

class ForgotMyPasswordBody extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  Orientation deviceOrientation;

  ForgotMyPasswordBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      TitleSection(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          deviceOrientation: deviceOrientation),
      Container(
          height: 0.50 * screenHeight,
          margin: EdgeInsets.only(top: 0.27 * screenHeight),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    raisingBlack,
                    black,
                  ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_boderRadius()),
                  topRight: Radius.circular(_boderRadius()))),
          child: EmailButtonsSection(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              deviceOrientation: deviceOrientation),
          alignment: Alignment.center)
    ]));
  }

  double _boderRadius() {
    return screenWidth *
        ((deviceOrientation == Orientation.portrait) ? 0.14 : 0.07);
  }
}

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
          height: 0.08 * screenHeight,
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
          height: 0.05 * screenHeight,
          margin: EdgeInsets.only(top: 0.02 * screenHeight),
          borderRadius: 0.03 * screenHeight,
          buttonColor: lightCoral)
    ]);
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.025 * screenHeight
        : 0.0195 * screenWidth;
  }
}

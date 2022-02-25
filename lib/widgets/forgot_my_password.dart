import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/forgot_my_password_email_buttons_section.dart';
import 'package:zenith_monitor/widgets/forgot_my_password_title_section.dart';

class ForgotMyPasswordBody extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;

  const ForgotMyPasswordBody(
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
              gradient: const LinearGradient(
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

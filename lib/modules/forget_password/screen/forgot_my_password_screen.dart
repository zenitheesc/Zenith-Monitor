import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/forgot_my_password.dart';

class ForgotMyPassword extends StatelessWidget {
  const ForgotMyPassword();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ForgotMyPasswordBody(
          screenWidth: MediaQuery.of(context).size.width,
          screenHeight: MediaQuery.of(context).size.height,
          deviceOrientation: MediaQuery.of(context).orientation),
      backgroundColor: eerieBlack,
    ));
  }
}

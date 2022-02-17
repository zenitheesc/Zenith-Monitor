import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/signup_main_body.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SignUpMainBody(rootContext: context),
        backgroundColor: eerieBlack,
      ),
    );
  }
}

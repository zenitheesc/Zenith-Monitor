import 'package:flutter/material.dart';
import 'package:zenith_monitor/widgets/signup_buttons_section.dart';
import 'package:zenith_monitor/widgets/signup_name_password_section.dart';
import 'package:zenith_monitor/widgets/signup_profile_image_section.dart';

class SignUpMainBody extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;

  const SignUpMainBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileImageSection(
                screenWidth: screenWidth, screenHeight: screenHeight),
            NamePasswordSection(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                deviceOrientation: deviceOrientation),
            ButtonsSection(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                deviceOrientation: deviceOrientation)
          ],
        ),
      ),
    );
  }
}

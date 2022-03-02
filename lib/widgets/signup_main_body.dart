import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/signup/bloc/sign_up_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/widgets/signup_buttons_section.dart';
import 'package:zenith_monitor/widgets/signup_name_password_section.dart';
import 'package:zenith_monitor/widgets/signup_profile_image_section.dart';

class SignUpMainBody extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;

  SignUpMainBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pwdConfirmController = TextEditingController();

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
              deviceOrientation: deviceOrientation,
              nameController: nameController,
              surnameController: surnameController,
              emailController: emailController,
              passwordController: passwordController,
              pwdConfirmController: pwdConfirmController,
            ),
            ButtonsSection(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              deviceOrientation: deviceOrientation,
              funcConfirm: () => BlocProvider.of<SignUpBloc>(context).add(
                  UserRegisterEvent(
                      newUser: LocalUser(nameController.text,
                          surnameController.text, null, emailController.text),
                      password: passwordController.text)),
            )
          ],
        ),
      ),
    );
  }
}

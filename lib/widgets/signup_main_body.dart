import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/signup/bloc/sign_up_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/widgets/signup_buttons_section.dart';
import 'package:zenith_monitor/widgets/signup_name_password_section.dart';
import 'package:zenith_monitor/widgets/signup_profile_image_section.dart';

class SignUpMainBody extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;

  SignUpMainBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  _SUPMainBodyState createState() => _SUPMainBodyState();
}

class _SUPMainBodyState extends State<SignUpMainBody> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController pwdConfirmController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    pwdConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    pwdConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileImageSection(
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight),
            NamePasswordSection(
              screenWidth: widget.screenWidth,
              screenHeight: widget.screenHeight,
              deviceOrientation: widget.deviceOrientation,
              nameController: nameController,
              surnameController: surnameController,
              emailController: emailController,
              passwordController: passwordController,
              pwdConfirmController: pwdConfirmController,
            ),
            ButtonsSection(
              screenWidth: widget.screenWidth,
              screenHeight: widget.screenHeight,
              deviceOrientation: widget.deviceOrientation,
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
